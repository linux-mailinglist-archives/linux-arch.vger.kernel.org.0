Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB6F64A667
	for <lists+linux-arch@lfdr.de>; Tue, 18 Jun 2019 18:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729754AbfFRQQa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Jun 2019 12:16:30 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:45512 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729349AbfFRQQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Jun 2019 12:16:29 -0400
Received: from mailhost.synopsys.com (dc2-mailhost2.synopsys.com [10.12.135.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BF6C5C0089;
        Tue, 18 Jun 2019 16:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1560874589; bh=xYS6mzOHcc5tZ2V6C5q7HclO0xQu5wKSyhWACyqHTxM=;
        h=From:To:CC:Subject:Date:References:From;
        b=IErIUbvgWmDQzo/N/ukCP4iWSxKG/wU16pdwTuTViSx4aq+hQulsmMRHaZ8OokKR4
         76ja1aXzvo5UBY0UL+dPIJF+Za8dvQ4ZAUeOeo7dCU+LXrCD1u6M8sHEtY8eMNeHG7
         61Zg4un2zJfQHn0KOry7NDmiT3HXFlg/uUePU5gbRandKBH4GpNjHStf6ZzEKyz7pC
         o6KmupVbT5gLN2WEh9tOcTKAPiKnUTqF9+VrOx9sbqolV1THhSQWYIz3bYjeCr9q0f
         CKaInVOAQqo8RjSiC8P0oBRetEF4vuRSnYvZ91sdIhwblCPohWIl9FKrUybAVB4kjn
         L1cwLq71TGkTw==
Received: from US01WXQAHTC1.internal.synopsys.com (us01wxqahtc1.internal.synopsys.com [10.12.238.230])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailhost.synopsys.com (Postfix) with ESMTPS id 4253DA009F;
        Tue, 18 Jun 2019 16:16:23 +0000 (UTC)
Received: from us01wembx1.internal.synopsys.com ([169.254.1.22]) by
 US01WXQAHTC1.internal.synopsys.com ([::1]) with mapi id 14.03.0415.000; Tue,
 18 Jun 2019 09:16:21 -0700
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>,
        Jason Baron <jbaron@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Ard Biesheuvel" <ard.biesheuvel@linaro.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Topic: [PATCH] ARC: ARCv2: jump label: implement jump label patching
Thread-Index: AQHVIs/0NQVi79UXq0qOEJsJAVWA8w==
Date:   Tue, 18 Jun 2019 16:16:20 +0000
Message-ID: <C2D7FE5348E1B147BCA15975FBA2307501A252CCC3@us01wembx1.internal.synopsys.com>
References: <20190614164049.31626-1-Eugeniy.Paltsev@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.13.184.19]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 6/14/19 9:41 AM, Eugeniy Paltsev wrote:=0A=
> Implement jump label patching for ARC. Jump labels provide=0A=
> an interface to generate dynamic branches using=0A=
> self-modifying code.=0A=
>=0A=
> This allows us to implement conditional branches where=0A=
> changing branch direction is expensive but branch selection=0A=
> is basically 'free'=0A=
>=0A=
> This implementation uses 32-bit NOP and BRANCH instructions=0A=
> which forced to be aligned by 4 to guarantee that they don't=0A=
> cross L1 cache line and can be update atomically.=0A=
>=0A=
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>=0A=
=0A=
LGTM overall - nits below.=0A=
=0A=
> ---=0A=
>  arch/arc/Kconfig                  |   8 ++=0A=
>  arch/arc/include/asm/jump_label.h |  68 ++++++++++++=0A=
>  arch/arc/kernel/Makefile          |   1 +=0A=
>  arch/arc/kernel/jump_label.c      | 168 ++++++++++++++++++++++++++++++=
=0A=
>  4 files changed, 245 insertions(+)=0A=
>  create mode 100644 arch/arc/include/asm/jump_label.h=0A=
>  create mode 100644 arch/arc/kernel/jump_label.c=0A=
>=0A=
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig=0A=
> index c781e45d1d99..b1313e016c54 100644=0A=
> --- a/arch/arc/Kconfig=0A=
> +++ b/arch/arc/Kconfig=0A=
> @@ -47,6 +47,7 @@ config ARC=0A=
>  	select OF_EARLY_FLATTREE=0A=
>  	select PCI_SYSCALL if PCI=0A=
>  	select PERF_USE_VMALLOC if ARC_CACHE_VIPT_ALIASING=0A=
> +	select HAVE_ARCH_JUMP_LABEL if ISA_ARCV2 && !CPU_ENDIAN_BE32=0A=
>  =0A=
>  config ARCH_HAS_CACHE_LINE_SIZE=0A=
>  	def_bool y=0A=
> @@ -529,6 +530,13 @@ config ARC_DW2_UNWIND=0A=
>  config ARC_DBG_TLB_PARANOIA=0A=
>  	bool "Paranoia Checks in Low Level TLB Handlers"=0A=
>  =0A=
> +config ARC_DBG_STATIC_KEYS=0A=
> +	bool "Paranoid checks in Static Keys code"=0A=
> +	depends on JUMP_LABEL=0A=
> +	select STATIC_KEYS_SELFTEST=0A=
> +	help=0A=
> +	  Enable paranoid checks and self-test of both ARC-specific and generic=
=0A=
> +	  part of static-keys-related code.=0A=
=0A=
Why can't we just enable this if STATIC_KEYS_SELFTEST=0A=
=0A=
>  endif=0A=
>  =0A=
>  config ARC_BUILTIN_DTB_NAME=0A=
> diff --git a/arch/arc/include/asm/jump_label.h b/arch/arc/include/asm/jum=
p_label.h=0A=
> new file mode 100644=0A=
> index 000000000000..8971d0608f2c=0A=
> --- /dev/null=0A=
> +++ b/arch/arc/include/asm/jump_label.h=0A=
> @@ -0,0 +1,68 @@=0A=
> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
> +#ifndef _ASM_ARC_JUMP_LABEL_H=0A=
> +#define _ASM_ARC_JUMP_LABEL_H=0A=
> +=0A=
> +#ifndef __ASSEMBLY__=0A=
> +=0A=
> +#include <linux/types.h>=0A=
> +=0A=
> +#define JUMP_LABEL_NOP_SIZE 4=0A=
> +=0A=
> +/*=0A=
> + * To make atomic update of patched instruction available we need to gua=
rantee=0A=
> + * that this instruction doesn't cross L1 cache line boundary.=0A=
> + *=0A=
> + * As of today we simply align instruction which can be patched by 4 byt=
e using=0A=
> + * ".balign 4" directive. In that case patched instruction is aligned wi=
th one=0A=
> + * 16-bit NOP_S if this is required.=0A=
> + * However 'align by 4' directive is much stricter than it actually requ=
ired.=0A=
> + * It's enough that our 32-bit instruction don't cross l1 cache line bou=
ndary=0A=
> + * which can be achieved by using ".bundle_align_mode" directive. That w=
ill save=0A=
> + * us from adding useless NOP_S padding in most of the cases.=0A=
> + *=0A=
> + * TODO: switch to ".bundle_align_mode" directive using whin it will be=
=0A=
> + * supported by ARC toolchain.=0A=
> + */=0A=
> +=0A=
=0A=
So block comments on top of a function imply summary of function etc.=0A=
What you are doing here is calling out the need for .balign quirk. So bette=
r to=0A=
phrase it is as "Note about .balign" and then describe the thing=0A=
=0A=
> +static __always_inline bool arch_static_branch(struct static_key *key,=
=0A=
> +					       bool branch)=0A=
> +{=0A=
> +	asm_volatile_goto(".balign 4			\n"=0A=
> +		 "1:					\n"=0A=
> +		 "nop					\n"=0A=
> +		 ".pushsection __jump_table, \"aw\"	\n"=0A=
> +		 ".word 1b, %l[l_yes], %c0		\n"=0A=
> +		 ".popsection				\n"=0A=
> +		 : : "i" (&((char *)key)[branch]) : : l_yes);=0A=
> +=0A=
> +	return false;=0A=
> +l_yes:=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +static __always_inline bool arch_static_branch_jump(struct static_key *k=
ey,=0A=
> +						    bool branch)=0A=
> +{=0A=
> +	asm_volatile_goto(".balign 4			\n"=0A=
> +		 "1:					\n"=0A=
> +		 "b %l[l_yes]				\n"=0A=
> +		 ".pushsection __jump_table, \"aw\"	\n"=0A=
> +		 ".word 1b, %l[l_yes], %c0		\n"=0A=
> +		 ".popsection				\n"=0A=
> +		 : : "i" (&((char *)key)[branch]) : : l_yes);=0A=
> +=0A=
> +	return false;=0A=
> +l_yes:=0A=
> +	return true;=0A=
> +}=0A=
> +=0A=
> +typedef u32 jump_label_t;=0A=
> +=0A=
> +struct jump_entry {=0A=
> +	jump_label_t code;=0A=
> +	jump_label_t target;=0A=
> +	jump_label_t key;=0A=
> +};=0A=
> +=0A=
> +#endif  /* __ASSEMBLY__ */=0A=
> +#endif=0A=
> diff --git a/arch/arc/kernel/Makefile b/arch/arc/kernel/Makefile=0A=
> index 2dc5f4296d44..307f74156d99 100644=0A=
> --- a/arch/arc/kernel/Makefile=0A=
> +++ b/arch/arc/kernel/Makefile=0A=
> @@ -22,6 +22,7 @@ obj-$(CONFIG_ARC_EMUL_UNALIGNED) 	+=3D unaligned.o=0A=
>  obj-$(CONFIG_KGDB)			+=3D kgdb.o=0A=
>  obj-$(CONFIG_ARC_METAWARE_HLINK)	+=3D arc_hostlink.o=0A=
>  obj-$(CONFIG_PERF_EVENTS)		+=3D perf_event.o=0A=
> +obj-$(CONFIG_JUMP_LABEL)		+=3D jump_label.o=0A=
>  =0A=
>  obj-$(CONFIG_ARC_FPU_SAVE_RESTORE)	+=3D fpu.o=0A=
>  CFLAGS_fpu.o   +=3D -mdpfp=0A=
> diff --git a/arch/arc/kernel/jump_label.c b/arch/arc/kernel/jump_label.c=
=0A=
> new file mode 100644=0A=
> index 000000000000..93e3bc84288f=0A=
> --- /dev/null=0A=
> +++ b/arch/arc/kernel/jump_label.c=0A=
> @@ -0,0 +1,168 @@=0A=
> +// SPDX-License-Identifier: GPL-2.0=0A=
> +=0A=
> +#include <linux/kernel.h>=0A=
> +#include <linux/jump_label.h>=0A=
> +=0A=
> +#include "asm/cacheflush.h"=0A=
> +=0A=
> +#define JUMPLABEL_ERR	"ARC: jump_label: ERROR: "=0A=
> +=0A=
> +/* Halt system on fatal error to make debug easier */=0A=
> +#define arc_jl_fatal(format...)						\=0A=
> +({									\=0A=
> +	pr_err(JUMPLABEL_ERR format);					\=0A=
> +	BUG();								\=0A=
=0A=
Does it make sense to bring down the whole system vs. failing and returning=
.=0A=
I see there is no error propagation to core code, but still.=0A=
=0A=
> +})=0A=
> +=0A=
> +static inline u32 arc_gen_nop(void)=0A=
> +{=0A=
> +	/* 1x 32bit NOP in middle endian */=0A=
> +	return 0x7000264a;=0A=
> +}=0A=
> +=0A=
> +static inline bool cross_l1_cache_line(void *addr, int len)=0A=
> +{=0A=
> +	unsigned long a =3D (unsigned long)addr;=0A=
> +=0A=
> +	return (a >> L1_CACHE_SHIFT) !=3D ((a + len - 1) >> L1_CACHE_SHIFT);=0A=
> +}=0A=
> +=0A=
> +/*=0A=
> + * ARCv2 'Branch unconditionally' instruction:=0A=
> + * 00000ssssssssss1SSSSSSSSSSNRtttt=0A=
> + * s S[n:0] lower bits signed immediate (number is bitfield size)=0A=
> + * S S[m:n+1] upper bits signed immediate (number is bitfield size)=0A=
> + * t S[24:21] upper bits signed immediate (branch unconditionally far)=
=0A=
> + * N N <.d> delay slot mode=0A=
> + * R R Reserved=0A=
> + */=0A=
> +static inline u32 arc_gen_branch(jump_label_t pc, jump_label_t target)=
=0A=
> +{=0A=
> +	u32 instruction_l, instruction_r;=0A=
> +	u32 pcl =3D pc & GENMASK(31, 2);=0A=
> +	u32 u_offset =3D target - pcl;=0A=
> +	u32 s, S, t;=0A=
> +=0A=
> +	/*=0A=
> +	 * Offset in 32-bit branch instruction must to fit into s25.=0A=
> +	 * Something is terribly broken if we get such huge offset within one=
=0A=
> +	 * function.=0A=
> +	 */=0A=
> +	if ((s32)u_offset < -16777216 || (s32)u_offset > 16777214)=0A=
> +		arc_jl_fatal("gen branch with offset (%d) not fit in s25\n",=0A=
> +			     (s32)u_offset);=0A=
> +=0A=
> +	/*=0A=
> +	 * All instructions are aligned by 2 bytes so we should never get offse=
t=0A=
> +	 * here which is not 2 bytes aligned.=0A=
> +	 */=0A=
> +	if (u_offset & 0x1)=0A=
> +		arc_jl_fatal("gen branch with offset (%d) unaligned to 2 bytes\n",=0A=
> +			     (s32)u_offset);=0A=
> +=0A=
> +	s =3D (u_offset >> 1)  & GENMASK(9, 0);=0A=
> +	S =3D (u_offset >> 11) & GENMASK(9, 0);=0A=
> +	t =3D (u_offset >> 21) & GENMASK(3, 0);=0A=
> +=0A=
> +	/* 00000ssssssssss1 */=0A=
> +	instruction_l =3D (s << 1) | 0x1;=0A=
> +	/* SSSSSSSSSSNRtttt */=0A=
> +	instruction_r =3D (S << 6) | t;=0A=
> +=0A=
> +	return (instruction_r << 16) | (instruction_l & GENMASK(15, 0));=0A=
> +}=0A=
> +=0A=
> +void arch_jump_label_transform(struct jump_entry *entry,=0A=
> +			       enum jump_label_type type)=0A=
> +{=0A=
> +	jump_label_t *instr_addr =3D (jump_label_t *)entry->code;=0A=
> +	u32 instr;=0A=
> +=0A=
> +	/*=0A=
> +	 * Atomic update of patched instruction is only available if this=0A=
> +	 * instruction doesn't cross L1 cache line boundary. You can read about=
=0A=
> +	 * the way we achieve this in arc/include/asm/jump_label.h=0A=
> +	 */=0A=
> +	if (cross_l1_cache_line(instr_addr, JUMP_LABEL_NOP_SIZE))=0A=
> +		arc_jl_fatal("instruction (addr %px) cross L1 cache line",=0A=
> +			     instr_addr);=0A=
> +=0A=
> +	if (type =3D=3D JUMP_LABEL_JMP)=0A=
> +		instr =3D arc_gen_branch(entry->code, entry->target);=0A=
> +	else=0A=
> +		instr =3D arc_gen_nop();=0A=
> +=0A=
> +	WRITE_ONCE(*instr_addr, instr);=0A=
> +	flush_icache_range(entry->code, entry->code + JUMP_LABEL_NOP_SIZE);=0A=
> +}=0A=
> +=0A=
> +void arch_jump_label_transform_static(struct jump_entry *entry,=0A=
> +				      enum jump_label_type type)=0A=
> +{=0A=
> +	/*=0A=
> +	 * We use only one NOP type (1x, 4 byte) in arch_static_branch, so=0A=
> +	 * there's no need to patch an identical NOP over the top of it here.=
=0A=
> +	 * The generic code calls 'arch_jump_label_transform' if the NOP needs=
=0A=
> +	 * to be replaced by a branch, so 'arch_jump_label_transform_static' is=
=0A=
> +	 * newer called with type other than JUMP_LABEL_NOP.=0A=
=0A=
s/newer/never=0A=
=0A=
> +	 */=0A=
> +	BUG_ON(type !=3D JUMP_LABEL_NOP);=0A=
> +}=0A=
> +=0A=
> +#ifdef CONFIG_ARC_DBG_STATIC_KEYS=0A=
> +#define SELFTEST_MSG	"ARC: instruction generation self-test: "=0A=
> +=0A=
> +struct arc_gen_branch_testdata {=0A=
> +	jump_label_t pc;=0A=
> +	jump_label_t target_address;=0A=
> +	u32 expected_instr;=0A=
> +};=0A=
> +=0A=
> +static __init int branch_gen_test(struct arc_gen_branch_testdata *test_d=
ata)=0A=
> +{=0A=
> +	u32 instr_got;=0A=
> +=0A=
> +	instr_got =3D arc_gen_branch(test_data->pc, test_data->target_address);=
=0A=
> +	if (instr_got !=3D test_data->expected_instr) {=0A=
> +		pr_err(SELFTEST_MSG "FAIL:\n arc_gen_branch(0x%08x, 0x%08x) !=3D 0x%08=
x, got 0x%08x\n",=0A=
> +		       test_data->pc, test_data->target_address,=0A=
> +		       test_data->expected_instr, instr_got);=0A=
> +=0A=
> +		return -EFAULT;=0A=
> +	}=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
> +static __init int instr_gen_test(void)=0A=
> +{=0A=
> +	int i, ret;=0A=
> +=0A=
> +	struct arc_gen_branch_testdata test_data[] =3D {=0A=
> +		{0x90007548, 0x90007514, 0xffcf07cd}, /* tiny (-52) offs */=0A=
> +		{0x9000c9c0, 0x9000c782, 0xffcf05c3}, /* tiny (-574) offs */=0A=
> +		{0x9000cc1c, 0x9000c782, 0xffcf0367}, /* tiny (-1178) offs */=0A=
> +		{0x9009dce0, 0x9009d106, 0xff8f0427}, /* small (-3034) offs */=0A=
> +		{0x9000f5de, 0x90007d30, 0xfc0f0755}, /* big  (-30892) offs */=0A=
> +		{0x900a2444, 0x90035f64, 0xc9cf0321}, /* huge (-443616) offs */=0A=
> +		{0x90007514, 0x9000752c, 0x00000019}, /* tiny (+24) offs */=0A=
> +		{0x9001a578, 0x9001a77a, 0x00000203}, /* tiny (+514) offs */=0A=
> +		{0x90031ed8, 0x90032634, 0x0000075d}, /* tiny (+1884) offs */=0A=
> +		{0x9008c7f2, 0x9008d3f0, 0x00400401}, /* small (+3072) offs */=0A=
> +		{0x9000bb38, 0x9003b340, 0x17c00009}, /* big  (+194568) offs */=0A=
> +		{0x90008f44, 0x90578d80, 0xb7c2063d}  /* huge (+5701180) offs */=0A=
> +	};=0A=
> +=0A=
> +	for (i =3D 0; i < ARRAY_SIZE(test_data); i++) {=0A=
> +		ret =3D branch_gen_test(&test_data[i]);=0A=
> +		if (ret)=0A=
> +			return ret;=0A=
> +	}=0A=
> +=0A=
> +	pr_info(SELFTEST_MSG "OK\n");=0A=
> +=0A=
> +	return 0;=0A=
> +}=0A=
> +early_initcall(instr_gen_test);=0A=
> +=0A=
> +#endif /* CONFIG_ARC_STATIC_KEYS_DEBUG */=0A=
=0A=

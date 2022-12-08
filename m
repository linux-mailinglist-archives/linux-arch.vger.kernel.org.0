Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D35646C77
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 11:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiLHKMW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 05:12:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLHKMW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 05:12:22 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49704201B8;
        Thu,  8 Dec 2022 02:12:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81259B821FE;
        Thu,  8 Dec 2022 10:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA13BC433D6;
        Thu,  8 Dec 2022 10:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494337;
        bh=8K6xSMcwj8HEh7gj15j+kTx7vLgtOrECzlS/8vJxW5E=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=lbHxv4N/eKKogFUBrwQgiv5ooZcJgkk835Mpg9YhuP0m4yrsX5cYYCc4bfj2BU2Zb
         nz2qSiHB8QuweCfb2b5aA8zzB+IHOsyzo2WcaH88zSfGgkWRRnBvjCvtglKP/i7VJO
         bt5EpGXwoKcQRZj01BKVdXqbe0NV3pkf/3B48GQx8Z+3jLnQM5owtBFT86NuxKac/Z
         rViu4uIjfd4t1r4N0XeyabSppdyvEPpymCm+KZv57D1m1tJfwnAM3HADDWSyfOFR6/
         y+JxdX6xHvzmYmUbT+AybYf8EpRPNvlvVUVAW9FAUp7ZHUEwIK2B5ebqTHNzEyuQyj
         aJcm4snPfxQDw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     guoren@kernel.org, arnd@arndb.de, guoren@kernel.org,
        palmer@rivosinc.com, tglx@linutronix.de, peterz@infradead.org,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com, ben@decadent.org.uk
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V10 08/10] riscv: stack: Support
 HAVE_IRQ_EXIT_ON_IRQ_STACK
In-Reply-To: <20221208025816.138712-9-guoren@kernel.org>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-9-guoren@kernel.org>
Date:   Thu, 08 Dec 2022 11:12:14 +0100
Message-ID: <87pmcuw6f5.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

guoren@kernel.org writes:

> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add independent irq stacks for percpu to prevent kernel stack overflows.
> It is also compatible with VMAP_STACK by implementing
> arch_alloc_vmap_stack.  Many architectures have supported
> HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.
>

I still would like to see this as a separate series, and that the
generic entry series ended with the previous patch. It's already a lot
of moving pieces in this series. Now add stack changes? Is this really
required for generic entry support?

Some comments below.

> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig                   |  8 ++++
>  arch/riscv/include/asm/thread_info.h |  2 +
>  arch/riscv/include/asm/vmap_stack.h  | 28 ++++++++++++
>  arch/riscv/kernel/irq.c              | 66 +++++++++++++++++++++++++++-
>  4 files changed, 102 insertions(+), 2 deletions(-)
>  create mode 100644 arch/riscv/include/asm/vmap_stack.h
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 518e8523d41d..0a9d4bdc0338 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -446,6 +446,14 @@ config FPU
>=20=20
>  	  If you don't know what to do here, say Y.
>=20=20
> +config IRQ_STACKS
> +	bool "Independent irq stacks" if EXPERT
> +	default y
> +	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> +	help
> +	  Add independent irq stacks for percpu to prevent kernel stack overflo=
ws.
> +	  We may save some memory footprint by disabling IRQ_STACKS.
> +

Other archs uses CONFIG_IRQSTACKS. Let's use that for riscv as well, and
also use the same Kconfig wording as the other archs.

>  endmenu # "Platform type"
>=20=20
>  menu "Kernel features"
> diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/as=
m/thread_info.h
> index 7de4fb96f0b5..043da8ccc7e6 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -40,6 +40,8 @@
>  #define OVERFLOW_STACK_SIZE     SZ_4K
>  #define SHADOW_OVERFLOW_STACK_SIZE (1024)
>=20=20
> +#define IRQ_STACK_SIZE		THREAD_SIZE
> +
>  #ifndef __ASSEMBLY__
>=20=20
>  extern long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE / sizeof(long)];
> diff --git a/arch/riscv/include/asm/vmap_stack.h b/arch/riscv/include/asm=
/vmap_stack.h
> new file mode 100644
> index 000000000000..3fbf481abf4f
> --- /dev/null
> +++ b/arch/riscv/include/asm/vmap_stack.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +// Copied from arch/arm64/include/asm/vmap_stack.h.
> +#ifndef _ASM_RISCV_VMAP_STACK_H
> +#define _ASM_RISCV_VMAP_STACK_H
> +
> +#include <linux/bug.h>
> +#include <linux/gfp.h>
> +#include <linux/kconfig.h>
> +#include <linux/vmalloc.h>
> +#include <linux/pgtable.h>
> +#include <asm/thread_info.h>
> +
> +/*
> + * To ensure that VMAP'd stack overflow detection works correctly, all V=
MAP'd
> + * stacks need to have the same alignment.
> + */
> +static inline unsigned long *arch_alloc_vmap_stack(size_t stack_size, in=
t node)
> +{
> +	void *p;
> +
> +	BUILD_BUG_ON(!IS_ENABLED(CONFIG_VMAP_STACK));
> +
> +	p =3D __vmalloc_node(stack_size, THREAD_ALIGN, THREADINFO_GFP, node,
> +			__builtin_return_address(0));
> +	return kasan_reset_tag(p);
> +}
> +
> +#endif /* _ASM_RISCV_VMAP_STACK_H */
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 24c2e1bd756a..5d77f692b198 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -10,6 +10,37 @@
>  #include <linux/irqchip.h>
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
> +#include <asm/vmap_stack.h>
> +
> +#ifdef CONFIG_IRQ_STACKS
> +static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
> +
> +#ifdef CONFIG_VMAP_STACK
> +static void init_irq_stacks(void)
> +{
> +	int cpu;
> +	ulong *p;
> +
> +	for_each_possible_cpu(cpu) {
> +		p =3D arch_alloc_vmap_stack(IRQ_STACK_SIZE, cpu_to_node(cpu));
> +		per_cpu(irq_stack_ptr, cpu) =3D p;
> +	}
> +}
> +#else
> +/* irq stack only needs to be 16 byte aligned - not IRQ_STACK_SIZE align=
ed. */
> +DEFINE_PER_CPU_ALIGNED(ulong [IRQ_STACK_SIZE/sizeof(ulong)], irq_stack);
> +
> +static void init_irq_stacks(void)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(irq_stack_ptr, cpu) =3D per_cpu(irq_stack, cpu);
> +}
> +#endif /* CONFIG_VMAP_STACK */
> +#else
> +static void init_irq_stacks(void) {}
> +#endif /* CONFIG_IRQ_STACKS */
>=20=20
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
> @@ -19,21 +50,52 @@ int arch_show_interrupts(struct seq_file *p, int prec)
>=20=20
>  void __init init_IRQ(void)
>  {
> +	init_irq_stacks();
>  	irqchip_init();
>  	if (!handle_arch_irq)
>  		panic("No interrupt controller found.");
>  }
>=20=20
> -asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
> +static void noinstr handle_riscv_irq(struct pt_regs *regs)
>  {
>  	struct pt_regs *old_regs;
> -	irqentry_state_t state =3D irqentry_enter(regs);
>=20=20
>  	irq_enter_rcu();
>  	old_regs =3D set_irq_regs(regs);
>  	handle_arch_irq(regs);
>  	set_irq_regs(old_regs);
>  	irq_exit_rcu();
> +}
> +
> +asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
> +{
> +	irqentry_state_t state =3D irqentry_enter(regs);
> +#ifdef CONFIG_IRQ_STACKS
> +	if (on_thread_stack()) {
> +		ulong *sp =3D per_cpu(irq_stack_ptr, smp_processor_id())
> +					+ IRQ_STACK_SIZE/sizeof(ulong);
> +		__asm__ __volatile(
> +		"addi	sp, sp, -"RISCV_SZPTR  "\n"
> +		REG_S"  ra, (sp)		\n"
> +		"addi	sp, sp, -"RISCV_SZPTR  "\n"
> +		REG_S"  s0, (sp)		\n"
> +		"addi	s0, sp, 2*"RISCV_SZPTR "\n"
> +		"move	sp, %[sp]		\n"
> +		"move	a0, %[regs]		\n"
> +		"call	handle_riscv_irq	\n"
> +		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
> +		REG_L"  s0, (sp)		\n"
> +		"addi	sp, sp, "RISCV_SZPTR   "\n"
> +		REG_L"  ra, (sp)		\n"
> +		"addi	sp, sp, "RISCV_SZPTR   "\n"
> +		:
> +		: [sp] "r" (sp), [regs] "r" (regs)
> +		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> +		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> +		  "memory");

This whole assembly thing will be C&P in later commits. Can we please do
something like x86 does here (call_on_stack --
arch/x86/include/asm/irq_stack.h), which will hurt our eyes a bit less,
and make it more maintainable?


Bj=C3=B6rn

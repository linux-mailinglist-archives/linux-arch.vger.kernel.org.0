Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104986CA268
	for <lists+linux-arch@lfdr.de>; Mon, 27 Mar 2023 13:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjC0LaZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Mar 2023 07:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0LaY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Mar 2023 07:30:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9925CBD;
        Mon, 27 Mar 2023 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1679916623; x=1711452623;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UErRcQFBZcG+0EjAJbcNi3TaUC0sRPYa3gULMuFzZG8=;
  b=pxU3Mn8t6ATzSzjh5ZFxuQ1hE9bCf3Wltbsk4sSuTeufzHiOtVmMwGhd
   pFBtmG9TlSuBO5duWyA4rLNjZZn+mtpG2TfBwUMUuSehHA3Zoo2nXAbZq
   P+dlC6exrrXW3CtKUjcl98EpB1aNh88eVXG2ZuHsFLJTsYhW8Ksw6hRfx
   7R+PKChDGbT7VFh3CmJKvAdfWX6LQl3AkPzaporau5lQI4lnhb4/LXnno
   WhMfSOhxtrgvWO1i5DzabFqME/S5Qoc2N26l97OTt18d5mp7vjbJkXOa0
   ZPWz8mVl1FHLH2k7tqv0CxvYsYGis2xauwU7t6dZ3158kZpj5fE6Wsl3A
   g==;
X-IronPort-AV: E=Sophos;i="5.98,294,1673938800"; 
   d="asc'?scan'208";a="206484759"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Mar 2023 04:30:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 27 Mar 2023 04:30:22 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 27 Mar 2023 04:30:19 -0700
Date:   Mon, 27 Mar 2023 12:41:37 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <guoren@kernel.org>
CC:     <arnd@arndb.de>, <palmer@rivosinc.com>, <tglx@linutronix.de>,
        <peterz@infradead.org>, <luto@kernel.org>, <heiko@sntech.de>,
        <jszhang@kernel.org>, <lazyparser@gmail.com>, <falcon@tinylab.org>,
        <chenhuacai@kernel.org>, <apatel@ventanamicro.com>,
        <atishp@atishpatra.org>, <mark.rutland@arm.com>,
        <bjorn@kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH -next V11 1/3] riscv: stack: Support
 HAVE_IRQ_EXIT_ON_IRQ_STACK
Message-ID: <f170c68c-4975-4f71-ac50-979483cb5848@spud>
References: <20230324071239.151677-1-guoren@kernel.org>
 <20230324071239.151677-2-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0KuVzuYzOpMI9LxQ"
Content-Disposition: inline
In-Reply-To: <20230324071239.151677-2-guoren@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--0KuVzuYzOpMI9LxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 24, 2023 at 03:12:37AM -0400, guoren@kernel.org wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
>=20
> Add independent irq stacks for percpu to prevent kernel stack overflows.
> It is also compatible with VMAP_STACK by implementing
> arch_alloc_vmap_stack.  Many architectures have supported
> HAVE_IRQ_EXIT_ON_IRQ_STACK, riscv should follow up.
>=20
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>

> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -9,6 +9,37 @@
>  #include <linux/irqchip.h>
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
> +#include <asm/vmap_stack.h>
> +
> +#ifdef CONFIG_IRQ_STACKS
> +DEFINE_PER_CPU(ulong *, irq_stack_ptr);

btw, sparse is complaining about this variable:
=2E./arch/riscv/kernel/irq.c:15:1: warning: symbol '__pcpu_scope_irq_stack_=
ptr' was not declared. Should it be static?

I'm not immediately sure why that is the case, but should be
reproducible with gcc-12 allmodconfig.

Thanks,
Conor.

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
> =20
>  int arch_show_interrupts(struct seq_file *p, int prec)
>  {
> @@ -18,6 +49,7 @@ int arch_show_interrupts(struct seq_file *p, int prec)
> =20
>  void __init init_IRQ(void)
>  {
> +	init_irq_stacks();
>  	irqchip_init();
>  	if (!handle_arch_irq)
>  		panic("No interrupt controller found.");
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index 1f4e37be7eb3..b69933ab6bf8 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -305,16 +305,50 @@ asmlinkage __visible noinstr void do_page_fault(str=
uct pt_regs *regs)
>  }
>  #endif
> =20
> -asmlinkage __visible noinstr void do_irq(struct pt_regs *regs)
> +static void noinstr handle_riscv_irq(struct pt_regs *regs)
>  {
>  	struct pt_regs *old_regs;
> -	irqentry_state_t state =3D irqentry_enter(regs);
> =20
>  	irq_enter_rcu();
>  	old_regs =3D set_irq_regs(regs);
>  	handle_arch_irq(regs);
>  	set_irq_regs(old_regs);
>  	irq_exit_rcu();
> +}
> +
> +#ifdef CONFIG_IRQ_STACKS
> +DECLARE_PER_CPU(ulong *, irq_stack_ptr);
> +#endif
> +
> +asmlinkage void noinstr do_irq(struct pt_regs *regs)
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
> +	} else
> +#endif
> +		handle_riscv_irq(regs);
> =20
>  	irqentry_exit(regs, state);
>  }
> --=20
> 2.36.1
>=20
>=20

--0KuVzuYzOpMI9LxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCGA8AAKCRB4tDGHoIJi
0j9/AQDtMWZnc3AMU2BAbos8sn2KzBZybbo+x9+gamWiNR925gD+I1kkh4/+2zTb
N9qngt9L4KlU3HhD65F92dkYTNrQCAk=
=5VJS
-----END PGP SIGNATURE-----

--0KuVzuYzOpMI9LxQ--

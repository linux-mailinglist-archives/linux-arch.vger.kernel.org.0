Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64665646C79
	for <lists+linux-arch@lfdr.de>; Thu,  8 Dec 2022 11:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiLHKMf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Dec 2022 05:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiLHKMb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Dec 2022 05:12:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5576173F44;
        Thu,  8 Dec 2022 02:12:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BBE27B82322;
        Thu,  8 Dec 2022 10:12:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBCC0C433C1;
        Thu,  8 Dec 2022 10:12:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670494343;
        bh=oSWBk5A/YjRMfCW/WvVQ9ZXtccAnJ070ZscZDewoBA8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fhBjHMg8aHSWYwKc5eAemS49AbwxRIeDH9bt2w8V2BitAB4uV0BeCtoXZx7Sn9JxB
         YWApAOm3gTzHpztRw+p4e8T2tXdM8SmCMiPDfDr02IB4J4YEK2UFmufzHbu/5oonS9
         bkjlEdAt8pZrPJ/vwYPh6CQlAUyySsLoFJ8QStEhnrmkIZUDl+s6v81mfVoTouEO+N
         onib47o8lexbKrLzmApXHKPwYBIa49seUnezt/a0m1xOhjiqZGYcmPd2pHi/ILH+nD
         KrK837YSpNTpa5ioRSoECUvxBGgNbrEFN7vcNysSrYSDPaCua99QtJ/U8W6s6BoL93
         6onmsyZI3kabQ==
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
Subject: Re: [PATCH -next V10 09/10] riscv: stack: Support
 HAVE_SOFTIRQ_ON_OWN_STACK
In-Reply-To: <20221208025816.138712-10-guoren@kernel.org>
References: <20221208025816.138712-1-guoren@kernel.org>
 <20221208025816.138712-10-guoren@kernel.org>
Date:   Thu, 08 Dec 2022 11:12:21 +0100
Message-ID: <87o7sew6ey.fsf@all.your.base.are.belong.to.us>
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
> Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config. The
> irq and softirq use the same independent irq_stack of percpu by time
> division multiplexing.
>
> Tested-by: Jisheng Zhang <jszhang@kernel.org>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/Kconfig      |  7 ++++---
>  arch/riscv/kernel/irq.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 0a9d4bdc0338..bd4c4ae4cdc9 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -447,12 +447,13 @@ config FPU
>  	  If you don't know what to do here, say Y.
>=20=20
>  config IRQ_STACKS
> -	bool "Independent irq stacks" if EXPERT
> +	bool "Independent irq & softirq stacks" if EXPERT
>  	default y
>  	select HAVE_IRQ_EXIT_ON_IRQ_STACK
> +	select HAVE_SOFTIRQ_ON_OWN_STACK

HAVE_IRQ_EXIT_ON_IRQ_STACK is used by softirq.c Shouldn't that be
selected introduced in this patch, instead of the previous one?

>  	help
> -	  Add independent irq stacks for percpu to prevent kernel stack overflo=
ws.
> -	  We may save some memory footprint by disabling IRQ_STACKS.
> +	  Add independent irq & softirq stacks for percpu to prevent kernel sta=
ck
> +	  overflows. We may save some memory footprint by disabling IRQ_STACKS.

Same comment from previous patch. Please use the same wording/config as
other archs.

>  endmenu # "Platform type"
>=20=20
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 5d77f692b198..a6406da34937 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -11,6 +11,7 @@
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
>  #include <asm/vmap_stack.h>
> +#include <asm/softirq_stack.h>
>=20=20
>  #ifdef CONFIG_IRQ_STACKS
>  static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
> @@ -38,6 +39,38 @@ static void init_irq_stacks(void)
>  		per_cpu(irq_stack_ptr, cpu) =3D per_cpu(irq_stack, cpu);
>  }
>  #endif /* CONFIG_VMAP_STACK */
> +
> +#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK
> +void do_softirq_own_stack(void)
> +{
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
> +		"call	__do_softirq		\n"
> +		"addi	sp, s0, -2*"RISCV_SZPTR"\n"
> +		REG_L"  s0, (sp)		\n"
> +		"addi	sp, sp, "RISCV_SZPTR   "\n"
> +		REG_L"  ra, (sp)		\n"
> +		"addi	sp, sp, "RISCV_SZPTR   "\n"
> +		:
> +		: [sp] "r" (sp)
> +		: "a0", "a1", "a2", "a3", "a4", "a5", "a6", "a7",
> +		  "t0", "t1", "t2", "t3", "t4", "t5", "t6",
> +		  "memory");

Same as previous patch. Please avoid C&P and have a look at how
call_on_stack is done on x86.


Bj=C3=B6rn

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE41D5BD8A5
	for <lists+linux-arch@lfdr.de>; Tue, 20 Sep 2022 02:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiITAMO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 20:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiITAMM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 20:12:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9EEC43336;
        Mon, 19 Sep 2022 17:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94AEAB80B16;
        Tue, 20 Sep 2022 00:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C95C433B5;
        Tue, 20 Sep 2022 00:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663632729;
        bh=jGh6Z/8o8phkxD6Q5ZaClfS96enuq/pckZpmt/gSUKw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QxfSf0QTdMROv8kOD4YiiscBiAFwlo9PR57pV30gJmTUhrNpU/yWDrH7eLYMgP6jK
         4AElYiaGpjieblpx1ymUfRCCwpdsuhxmRdDBBVCtNUk0JULVG7i6Tk8r8czAHGn08j
         MBBSR5x1J3eJKDggrNpdTb7tjQ+pjnSxHlCwGTWe7w/PYA2UXRli85h6LKs+fhbjT6
         VZx80+WFkDW30LgD7SETB2DCnkd6Krj0/cFx3zmmtk+SNp1YtBxiso4SFiIgiNvkte
         uR3c+udyxrbhe308ZeBZELRHAlq41d1lMahVvd0r8cqTN3VJ1uvQ0eiLq32Q/8wMfa
         Sl8TXtoN4T7og==
Received: by mail-oi1-f175.google.com with SMTP id m81so1682320oia.1;
        Mon, 19 Sep 2022 17:12:09 -0700 (PDT)
X-Gm-Message-State: ACrzQf3FXJqkua7FaiGxOiuPkSkRAEvdnc5oC7Axp+LEGA+hEN/x3Bj9
        HrziwawLRDFnj33CDhNrSkY70Gxs0oEJnDaz35k=
X-Google-Smtp-Source: AMsMyM7q6m74X81UqNxrOeCx3Dxj/WxoLF1r3ltRRUbJziqD0ESkxDrh6zD8VT0RsW27eG0Uex4S1P+7jPii4oPq1r0=
X-Received: by 2002:a05:6808:201f:b0:34f:9fdf:dbbf with SMTP id
 q31-20020a056808201f00b0034f9fdfdbbfmr356862oiw.19.1663632728293; Mon, 19 Sep
 2022 17:12:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220918155246.1203293-1-guoren@kernel.org> <20220918155246.1203293-10-guoren@kernel.org>
In-Reply-To: <20220918155246.1203293-10-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 20 Sep 2022 08:11:55 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRtRzeDqr3=AUkGadPMmMA6kwU86+zSNn8+0qXSk8zmVQ@mail.gmail.com>
Message-ID: <CAJF2gTRtRzeDqr3=AUkGadPMmMA6kwU86+zSNn8+0qXSk8zmVQ@mail.gmail.com>
Subject: Re: [PATCH V5 09/11] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 18, 2022 at 11:53 PM <guoren@kernel.org> wrote:
>
> From: Guo Ren <guoren@linux.alibaba.com>
>
> Add the HAVE_SOFTIRQ_ON_OWN_STACK feature for the IRQ_STACKS config. The
> irq and softirq use the same independent irq_stack of percpu by time
> division multiplexing.
>
> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  arch/riscv/Kconfig      |  7 ++++---
>  arch/riscv/kernel/irq.c | 16 ++++++++++++++++
>  2 files changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 75db47a983f2..dfe600f3526c 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -434,12 +434,13 @@ config FPU
>           If you don't know what to do here, say Y.
>
>  config IRQ_STACKS
> -       bool "Independent irq stacks" if EXPERT
> +       bool "Independent irq & softirq stacks" if EXPERT
>         default y
>         select HAVE_IRQ_EXIT_ON_IRQ_STACK
> +       select HAVE_SOFTIRQ_ON_OWN_STACK
>         help
> -         Add independent irq stacks for percpu to prevent kernel stack overflows.
> -         We may save some memory footprint by disabling IRQ_STACKS.
> +         Add independent irq & softirq stacks for percpu to prevent kernel stack
> +         overflows. We may save some memory footprint by disabling IRQ_STACKS.
>
>  endmenu # "Platform type"
>
> diff --git a/arch/riscv/kernel/irq.c b/arch/riscv/kernel/irq.c
> index 5ad4952203c5..6dc9ccd01470 100644
> --- a/arch/riscv/kernel/irq.c
> +++ b/arch/riscv/kernel/irq.c
> @@ -11,6 +11,7 @@
>  #include <linux/seq_file.h>
>  #include <asm/smp.h>
>  #include <asm/vmap_stack.h>
> +#include <asm/softirq_stack.h>
>
>  #ifdef CONFIG_IRQ_STACKS
>  static DEFINE_PER_CPU(ulong *, irq_stack_ptr);
> @@ -38,6 +39,21 @@ static void init_irq_stacks(void)
>                 per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
>  }
>  #endif /* CONFIG_VMAP_STACK */
> +
> +#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK
Sorry, it should be. If you compiled an error, please modify it manually,
+#ifdef CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK

> +static void do_riscv_softirq(struct pt_regs *regs)
> +{
> +       __do_softirq();
> +}
> +
> +void do_softirq_own_stack(void)
> +{
> +       ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
> +
> +       call_on_stack(NULL, sp, do_riscv_softirq, 0);
> +}
> +#endif /* CONFIG_SOFTIRQ_ON_OWN_STACK */
> +
>  #else
>  static void init_irq_stacks(void) {}
>  #endif /* CONFIG_IRQ_STACKS */
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren

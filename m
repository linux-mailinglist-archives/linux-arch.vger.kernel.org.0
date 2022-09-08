Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D05B22FA
	for <lists+linux-arch@lfdr.de>; Thu,  8 Sep 2022 18:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbiIHQBq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 8 Sep 2022 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiIHQBp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 8 Sep 2022 12:01:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58AC697E;
        Thu,  8 Sep 2022 09:01:43 -0700 (PDT)
Date:   Thu, 8 Sep 2022 18:01:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662652901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yq5ZQcpZgpbBySLyDiNZZpodPZiaJP/0RYxixe2+d8Y=;
        b=e48N5fhr2y9PwwEu4uAAHEca8MQ1r9J0zvBqQ4mqQAv8TJiw4oXHTwLajcP8Ov9mUuTY2A
        NY7+gsgPYsD3qZ5oW4C6q0N0UYLaBf7V63qtTrDVVX59UtMUG9TbQGkeeKj5rZowcgD1rZ
        RpiA1SbHcPIcGodqhzQzB2cDtBNQ+KMH6kjTUs4lYStFI9jvb30FeYms3LqNX11neDKg6F
        V41X60sakn2aUL6Beatbop1XjlAI5+Ct62PB8ULQJ528p43sPgHsfG0iXPsSGcIn3Mc4OS
        gTsyEwC2qz/ZnMTeAo7Fx0TkKYpiQb3RrhNc9SOX7BLF0Suxe0eO0wGWopkKDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662652901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yq5ZQcpZgpbBySLyDiNZZpodPZiaJP/0RYxixe2+d8Y=;
        b=aMO74v0Iyk5F71GBnyRyg+lFUxAvArjrSitIstuy8jq+PoE6YxmdL1Ii01YRHsh5Y9xYd0
        +XKKoqZcfnhU+fBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        peterz@infradead.org, luto@kernel.org, conor.dooley@microchip.com,
        heiko@sntech.de, jszhang@kernel.org, lazyparser@gmail.com,
        falcon@tinylab.org, chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V4 7/8] riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
Message-ID: <YxoR5Fv6hOkzMSTg@linutronix.de>
References: <20220908022506.1275799-1-guoren@kernel.org>
 <20220908022506.1275799-8-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908022506.1275799-8-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022-09-07 22:25:05 [-0400], guoren@kernel.org wrote:
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
>  		per_cpu(irq_stack_ptr, cpu) = per_cpu(irq_stack, cpu);
>  }
>  #endif /* CONFIG_VMAP_STACK */
> +
> +#ifndef CONFIG_PREEMPT_RT

Could you please replace it with 
	#ifdef CONFIG_SOFTIRQ_ON_OWN_STACK

instead? See
	https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git/commit/?id=8cbb2b50ee2dcb082675237eaaa48fe8479f8aa5

> +static void do_riscv_softirq(struct pt_regs *regs)
> +{
> +	__do_softirq();
> +}
> +
> +void do_softirq_own_stack(void)
> +{
> +	ulong *sp = per_cpu(irq_stack_ptr, smp_processor_id());
> +
> +	call_on_stack(NULL, sp, do_riscv_softirq, 0);
> +}
> +#endif /* CONFIG_PREEMPT_RT */
> +
>  #else
>  static void init_irq_stacks(void) {}
>  #endif /* CONFIG_IRQ_STACKS */

Sebastian

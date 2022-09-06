Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2245AE401
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 11:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiIFJVG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 05:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiIFJVF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 05:21:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFB965D0C2;
        Tue,  6 Sep 2022 02:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vy6nhn+svKRWk4UHHjIpjrQPm3rnkDXTTEC9kQv7hsI=; b=m+cdFEpiagnAD0rrm6GsVDWg3B
        2Rk21UjJ5I47wq+rl9+JefLh4rt5d2c1T78jtRBAsTx5gYUmfEZRipHr8uCSESCeyQClCka0t2xlZ
        MLSQ9OwhvtSviIC5TGH3xqEkE9Wey1XadKVr7M2HPoSnX0v1pBdnnIErQmZNA5ocZY0A/kjqvWixG
        pPjyC8sULaMaAERtQZK1Hdvdj3FwcA2qT5w4ZtnSSF2QGKuZnxsfigyGCrcBs94/42/TMXO3Xofj9
        /p9I+ae4AHtYpM7Cn7zb+IDsUVlSYPqn1uJgUqD0vd3e8qvcosd+IE26idDdnYpEK7sZiYytz6NOy
        /yamx01g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVUlA-00AGRW-KJ; Tue, 06 Sep 2022 09:20:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B0909300023;
        Tue,  6 Sep 2022 11:20:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EA1920239D76; Tue,  6 Sep 2022 11:20:40 +0200 (CEST)
Date:   Tue, 6 Sep 2022 11:20:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V3 4/7] riscv: convert to generic entry
Message-ID: <YxcQ6NoPf3AH0EXe@hirez.programming.kicks-ass.net>
References: <20220906035423.634617-1-guoren@kernel.org>
 <20220906035423.634617-5-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906035423.634617-5-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 05, 2022 at 11:54:20PM -0400, guoren@kernel.org wrote:

> +asmlinkage void noinstr do_riscv_irq(struct pt_regs *regs)
> +{
> +	struct pt_regs *old_regs;
> +	irqentry_state_t state = irqentry_enter(regs);
> +
> +	irq_enter_rcu();
> +	old_regs = set_irq_regs(regs);
> +	handle_arch_irq(regs);
> +	set_irq_regs(old_regs);
> +	irq_exit_rcu();
> +
> +	irqentry_exit(regs, state);
> +}

The above is right in that everything that calls irqentry_enter() should
be noinstr; however all the below instances get it wrong:

>  #define DO_ERROR_INFO(name, signo, code, str)				\
>  asmlinkage __visible __trap_section void name(struct pt_regs *regs)	\
>  {									\
> +	irqentry_state_t state = irqentry_enter(regs);			\
>  	do_trap_error(regs, signo, code, regs->epc, "Oops - " str);	\
> +	irqentry_exit(regs, state);					\
>  }
>  
>  DO_ERROR_INFO(do_trap_unknown,
> @@ -123,18 +126,22 @@ int handle_misaligned_store(struct pt_regs *regs);
>  
>  asmlinkage void __trap_section do_trap_load_misaligned(struct pt_regs *regs)
>  {
> +	irqentry_state_t state = irqentry_enter(regs);
>  	if (!handle_misaligned_load(regs))
>  		return;
>  	do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
>  		      "Oops - load address misaligned");
> +	irqentry_exit(regs, state);
>  }
>  
>  asmlinkage void __trap_section do_trap_store_misaligned(struct pt_regs *regs)
>  {
> +	irqentry_state_t state = irqentry_enter(regs);
>  	if (!handle_misaligned_store(regs))
>  		return;
>  	do_trap_error(regs, SIGBUS, BUS_ADRALN, regs->epc,
>  		      "Oops - store (or AMO) address misaligned");
> +	irqentry_exit(regs, state);
>  }
>  #endif
>  DO_ERROR_INFO(do_trap_store_fault,
> @@ -158,6 +165,8 @@ static inline unsigned long get_break_insn_length(unsigned long pc)
>  
>  asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  {
> +	irqentry_state_t state = irqentry_enter(regs);
> +
>  #ifdef CONFIG_KPROBES
>  	if (kprobe_single_step_handler(regs))
>  		return;
> @@ -185,6 +194,8 @@ asmlinkage __visible __trap_section void do_trap_break(struct pt_regs *regs)
>  		regs->epc += get_break_insn_length(regs->epc);
>  	else
>  		die(regs, "Kernel BUG");
> +
> +	irqentry_exit(regs, state);
>  }
>  NOKPROBE_SYMBOL(do_trap_break);

> +asmlinkage void do_page_fault(struct pt_regs *regs)
> +{
> +	irqentry_state_t state = irqentry_enter(regs);
> +
> +	__do_page_fault(regs);
> +
> +	irqentry_exit(regs, state);
> +}
>  NOKPROBE_SYMBOL(do_page_fault);

Without noinstr the compiler is free to insert instrumentation (think
all the k*SAN, KCov, GCov, ftrace etc..) which can call code we're not
yet ready to run this early in the entry path, for instance it could
rely on RCU which isn't on yet, or expect lockdep state.



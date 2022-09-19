Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCF5BCD58
	for <lists+linux-arch@lfdr.de>; Mon, 19 Sep 2022 15:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiISNfH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 19 Sep 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiISNfF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 19 Sep 2022 09:35:05 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23101E0E5;
        Mon, 19 Sep 2022 06:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YrQErvD5aTHNtMMFMvCNd+tRu0DRAE3Ac96/4No0n68=; b=UXM58Jc95iA8ylu7QLPL+yn1UC
        KwsT7hYHmSlBdWXnqdOhFLBkfmHGlipreMaL6DMvVy+BxkgCTt15NtVMwiI5x4W7QuWfxuIWfEXSM
        sKLOxo4BXbChNP8AQsRKj742EQwGc5f0DiDOeNujrgWId3A9DbXFzdLnl4EmALX9+62dslQhBwjAq
        +7/OkGvK+ckl0vX8AeGreyg1lh+viJRTp0Z6AOkDHYr6ryFzqxxxnOwrkzZXOdQIqE9pG8KrLwTVX
        BHNcyqy3xqvvghmxsqElO6YYtXBt49SIkgc33wcpcTOyB8Une1v9/Os9FVEEG50QeOv0p77Q7m3mS
        wJelsIqA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oaGus-004jbu-IG; Mon, 19 Sep 2022 13:34:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D2C4F300074;
        Mon, 19 Sep 2022 15:34:25 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B37DA2B634088; Mon, 19 Sep 2022 15:34:25 +0200 (CEST)
Date:   Mon, 19 Sep 2022 15:34:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     guoren@kernel.org
Cc:     arnd@arndb.de, palmer@rivosinc.com, tglx@linutronix.de,
        luto@kernel.org, conor.dooley@microchip.com, heiko@sntech.de,
        jszhang@kernel.org, lazyparser@gmail.com, falcon@tinylab.org,
        chenhuacai@kernel.org, apatel@ventanamicro.com,
        atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: Re: [PATCH V5 07/11] riscv: convert to generic entry
Message-ID: <Yyhv4UUXuSfvMOw+@hirez.programming.kicks-ass.net>
References: <20220918155246.1203293-1-guoren@kernel.org>
 <20220918155246.1203293-8-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918155246.1203293-8-guoren@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Sep 18, 2022 at 11:52:42AM -0400, guoren@kernel.org wrote:

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

FWIW; on x86 I've classified many of the 'from-kernel' traps as
NMI-like, since those traps can happen from any context, including with
IRQs disabled.

The basic shape of the trap handlers looks a little like:

	if (user_mode(regs)) {
		irqenrty_enter_from_user_mode(regs);
		do_user_trap();
		irqentry_exit_to_user_mode(regs);
	} else {
		irqentry_state_t state = irqentry_nmi_enter(regs);
		do_kernel_trap();
		irqentry_nmi_exit(regs, state);
	}

Not saying you have to match Risc-V in this patch-set, just something to
consider.

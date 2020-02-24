Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9B16AB4F
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 17:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBXQ1M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 11:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:37454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbgBXQ1L (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 11:27:11 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD3372080D;
        Mon, 24 Feb 2020 16:27:09 +0000 (UTC)
Date:   Mon, 24 Feb 2020 11:27:08 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Greg KH <gregkh@linuxfoundation.org>, gustavo@embeddedor.com,
        Thomas Gleixner <tglx@linutronix.de>, paulmck@kernel.org,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v4 05/27] x86: Replace ist_enter() with nmi_enter()
Message-ID: <20200224112708.4f307ba3@gandalf.local.home>
In-Reply-To: <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
        <20200221134215.328642621@infradead.org>
        <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
        <20200221202246.GA14897@hirez.programming.kicks-ass.net>
        <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 24 Feb 2020 11:43:46 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> -dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> +dotraplinkage notrace void do_int3(struct pt_regs *regs, long error_code)
>  {
>  	if (poke_int3_handler(regs))
>  		return;
>  
>  	/*
> -	 * Use ist_enter despite the fact that we don't use an IST stack.
> -	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> -	 * mode or even during context tracking state changes.
> -	 *
> -	 * This means that we can't schedule.  That's okay.
> +	 * Unlike any other non-IST entry, we can be called from pretty much
> +	 * any location in the kernel through kprobes -- text_poke() will most
> +	 * likely be handled by poke_int3_handler() above. This means this
> +	 * handler is effectively NMI-like.
>  	 */
> -	ist_enter(regs);
> +	nmi_enter();

Hmm, note that nmi_enter() calls other functions. Did you make sure
all of them are not able to be kprobed. This is different than just
being "NMI like", it's that if they are kprobed, then this will go into
an infinite loop because nothing can have a kprobe before the kprobe
int3 handler is called here.

-- Steve


>  	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
>  #ifdef CONFIG_KGDB_LOW_LEVEL_TRAP
>  	if (kgdb_ll_trap(DIE_INT3, "int3", regs, error_code, X86_TRAP_BP,
> @@ -563,7 +530,7 @@ dotraplinkage void notrace do_int3(struc
>  	cond_local_irq_disable(regs);
>  
>  exit:
> -	ist_exit(regs);
> +	nmi_exit();
>  }
>  NOKPROBE_SYMBOL(do_int3);

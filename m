Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5766E15AAEC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728052AbgBLOZm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 09:25:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:43578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727963AbgBLOZm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 09:25:42 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CACE120873;
        Wed, 12 Feb 2020 14:25:40 +0000 (UTC)
Date:   Wed, 12 Feb 2020 09:25:39 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH 5/8] x86,tracing: Mark debug_stack_{set_zero,reset)()
 notrace
Message-ID: <20200212092539.135934e1@gandalf.local.home>
In-Reply-To: <20200212094107.894657838@infradead.org>
References: <20200212093210.468391728@infradead.org>
        <20200212094107.894657838@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 12 Feb 2020 10:32:15 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Because do_nmi() must not call into tracing outside of
> nmi_enter()/nmi_exit(), these functions must be notrace.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/common.c |    4 ++--
>  arch/x86/kernel/nmi.c        |    6 ++++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c

This entire file is notrace:

 arch/x86/kernel/cpu/Makefile:

   CFLAGS_REMOVE_common.o = -pg

-- Steve

> @@ -1690,14 +1690,14 @@ void syscall_init(void)
>  DEFINE_PER_CPU(int, debug_stack_usage);
>  DEFINE_PER_CPU(u32, debug_idt_ctr);
>  
> -void debug_stack_set_zero(void)
> +void notrace debug_stack_set_zero(void)
>  {
>  	this_cpu_inc(debug_idt_ctr);
>  	load_current_idt();
>  }
>  NOKPROBE_SYMBOL(debug_stack_set_zero);
>  
> -void debug_stack_reset(void)
> +void notrace debug_stack_reset(void)
>  {
>  	if (WARN_ON(!this_cpu_read(debug_idt_ctr)))
>  		return;
> --- a/arch/x86/kernel/nmi.c
> +++ b/arch/x86/kernel/nmi.c
> @@ -534,6 +534,9 @@ do_nmi(struct pt_regs *regs, long error_
>  	}
>  #endif
>  
> +	/*
> +	 * It is important that no tracing happens before nmi_enter()!
> +	 */
>  	nmi_enter();
>  
>  	inc_irq_stat(__nmi_count);
> @@ -542,6 +545,9 @@ do_nmi(struct pt_regs *regs, long error_
>  		default_do_nmi(regs);
>  
>  	nmi_exit();
> +	/*
> +	 * No tracing after nmi_exit()!
> +	 */
>  
>  #ifdef CONFIG_X86_64
>  	if (unlikely(this_cpu_read(update_debug_stack))) {
> 


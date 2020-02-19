Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B967F16496D
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSQFC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:05:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726645AbgBSQFC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:05:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=91dYN2XAchNltNFxe1RzUEx2QBi5XhNqDW8tutVyliM=; b=roLTCcJRJPqnst7TzLFTAsciCr
        driprkHWQ4GwsXN5Nprhd6ryKUsrVYzQnGXxj6++o3hJ2hgXcOWR9wwBmKJyjNTAiRAh1xYXIrdcW
        DN0Wknr8PqkzmKAOnbQQCTP//T63gu75nRaoeM3zQc9XISnJAWit67esVyuK1oPdDXZZlQWKASZec
        j8uO7i7ddWeeIjWLFaMVcJ4ZLkJmHNDxQeLTYErZbnlYbrlTJjqKwQGDu8BdweENqOuy9lHLEtVQ4
        ocUvbZ7XeaXyhy8nTED0XXkQqpDnHVTyJ1EMP8IhCueVqQtgon6vqzvGCNfAusCq1XL5eN7H4z21V
        2KaVDykg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4Rq8-0000pw-RH; Wed, 19 Feb 2020 16:04:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9004C304D2C;
        Wed, 19 Feb 2020 17:02:50 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04654201E47AA; Wed, 19 Feb 2020 17:04:43 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:04:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200219160442.GE14946@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
 <20200219155715.GD14946@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219155715.GD14946@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 04:57:15PM +0100, Peter Zijlstra wrote:
> Something like so, I suppose...
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index 6ef00eb6fbb9..543de932dc7c 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -350,14 +350,20 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
>  		regs->ip == (unsigned long)native_irq_return_iret)
>  	{
>  		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
> +		unsigned long *dst = &gpregs->ip;
> +		unsigned long *src = (void *)regs->dp;
> +		int i, count = 5;
>  
>  		/*
>  		 * regs->sp points to the failing IRET frame on the
>  		 * ESPFIX64 stack.  Copy it to the entry stack.  This fills
>  		 * in gpregs->ss through gpregs->ip.
> -		 *
>  		 */
> -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> +		for (i = 0; i < count; i++) {
> +			int idx = (dst <= src) ? i : count - i;

That's an off-by-one for going backward; 'count - 1 - i' should work
better, or I should just stop typing for today ;-)

> +			dst[idx] = src[idx];
> +		}
> +
>  		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
>  
>  		/*

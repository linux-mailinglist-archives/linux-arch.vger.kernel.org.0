Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D431216B730
	for <lists+linux-arch@lfdr.de>; Tue, 25 Feb 2020 02:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgBYBaR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 20:30:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:52956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728523AbgBYBaR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 20:30:17 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D1E72072D;
        Tue, 25 Feb 2020 01:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582594216;
        bh=GjtdDzSg925EvRvuss62o0/Sozp5pFNL+UBdSosNKu0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ncFXRFn3EfzgklPksvD1a/YxzHLICZpHk76ZwRvrXjd6jg8xJ7LdePWTIoHid4fZX
         oWxN5CtX9Q5a57E2JHcZTJW/h6bHoSTkFzbfXYLuwR96L5zFdy0AUnn7x46mU4Qgyc
         mHF746mIYaTvnskI8RAlUnKc/qivqIU/UVPONVbw=
Date:   Tue, 25 Feb 2020 02:30:14 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200225013013.GA28329@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
 <20200221222129.GB28251@lenoir>
 <20200224121331.tnkvp6mmjchm4s2i@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224121331.tnkvp6mmjchm4s2i@pathway.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 01:13:31PM +0100, Petr Mladek wrote:
> On Fri 2020-02-21 23:21:30, Frederic Weisbecker wrote:
> > If the outermost NMI is interrupted while between printk_nmi_enter()
> > and preempt_count_add(), there is still a risk that we race and clear?
> 
> Great catch!
> 
> There is plenty of space in the printk_context variable. I would
> reserve one byte there for the NMI context to be on the safe side
> and be done with it.
> 
> It should never overflow. The BUG_ON(in_nmi() == NMI_MASK)
> in nmi_enter() will trigger much earlier.
> 
> Also I hope that printk_context will get removed with
> the lockless printk() implementation soon anyway.

Cool, because it's sad that we have to mimic/mirror the preempt count
with printk_context just for the sake of debugging preempt_count_add()
and other early code in nmi_enter().

The diff below looks good, thanks!

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>


> 
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index c8e6ab689d42..109c5ab70a0c 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -6,9 +6,11 @@
>  
>  #ifdef CONFIG_PRINTK
>  
> -#define PRINTK_SAFE_CONTEXT_MASK	 0x3fffffff
> -#define PRINTK_NMI_DIRECT_CONTEXT_MASK	 0x40000000
> -#define PRINTK_NMI_CONTEXT_MASK		 0x80000000
> +#define PRINTK_SAFE_CONTEXT_MASK	0x007ffffff
> +#define PRINTK_NMI_DIRECT_CONTEXT_MASK	0x008000000
> +#define PRINTK_NMI_CONTEXT_MASK		0xff0000000
> +
> +#define PRINTK_NMI_CONTEXT_OFFSET	0x010000000
>  
>  extern raw_spinlock_t logbuf_lock;
>  
> diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
> index b4045e782743..e8989418a139 100644
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -296,12 +296,12 @@ static __printf(1, 0) int vprintk_nmi(const char *fmt, va_list args)
>  
>  void notrace printk_nmi_enter(void)
>  {
> -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	this_cpu_add(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
>  }
>  
>  void notrace printk_nmi_exit(void)
>  {
> -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> +	this_cpu_sub(printk_context, PRINTK_NMI_CONTEXT_OFFSET);
>  }
>  
>  /*
> 
> Best Regards,
> Petr

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18441689E5
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 23:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUWVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 17:21:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:51716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726731AbgBUWVc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 17:21:32 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9E95206EF;
        Fri, 21 Feb 2020 22:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582323692;
        bh=U/Oe2Su9cuXS7/C3XLr+LnlhDygRGvtF3EzpD4iJeKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mwDTTULy0+GJiAIQNMKNw6SrH+g+EQukVaXs8PSIYZHhbcGmJvpqFnWHqZi0/yrfU
         n/6ZtG9Olr90e7B1THF5lFr7PosQFm0DVYE3beSXlddM9Lm5s+vnntqCZARt3ocu+r
         khkX0m5CocedMaPFXA22dN3eoErFRG9lMJbiOOQc=
Date:   Fri, 21 Feb 2020 23:21:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, dan.carpenter@oracle.com,
        mhiramat@kernel.org, Will Deacon <will@kernel.org>,
        Petr Mladek <pmladek@suse.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v4 02/27] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200221222129.GB28251@lenoir>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.149193474@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221134215.149193474@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 02:34:18PM +0100, Peter Zijlstra wrote:
> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Acked-by: Will Deacon <will@kernel.org>
> Acked-by: Marc Zyngier <maz@kernel.org>
> ---
>  arch/arm64/include/asm/hardirq.h |    4 ++--
>  arch/arm64/kernel/sdei.c         |   14 ++------------
>  arch/arm64/kernel/traps.c        |    8 ++------
>  arch/powerpc/kernel/traps.c      |   22 ++++++----------------
>  include/linux/hardirq.h          |    5 ++++-
>  include/linux/preempt.h          |    4 ++--
>  kernel/printk/printk_safe.c      |    6 ++++--
>  7 files changed, 22 insertions(+), 41 deletions(-)
> 
> --- a/kernel/printk/printk_safe.c
> +++ b/kernel/printk/printk_safe.c
> @@ -296,12 +296,14 @@ static __printf(1, 0) int vprintk_nmi(co
>  
>  void notrace printk_nmi_enter(void)
>  {
> -	this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
> +	if (!in_nmi())
> +		this_cpu_or(printk_context, PRINTK_NMI_CONTEXT_MASK);
>  }
>  
>  void notrace printk_nmi_exit(void)
>  {
> -	this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
> +	if (!in_nmi())
> +		this_cpu_and(printk_context, ~PRINTK_NMI_CONTEXT_MASK);
>  }

If the outermost NMI is interrupted while between printk_nmi_enter()
and preempt_count_add(), there is still a risk that we race and clear?

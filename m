Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79DF4165DAD
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgBTMid (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 07:38:33 -0500
Received: from merlin.infradead.org ([205.233.59.134]:52392 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgBTMid (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Feb 2020 07:38:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bcJGrENIxStVO5U2yoDpjYTpnIM80UF8M699WOXfM+8=; b=PmaWFZbV67o/inyTG2Fa5dNjrZ
        Wvcg2n6QFFc10N1cG2b/GrrA0ArZL1vuzUxp3zuGX8RiH6wMjoH7SWkVcM+WX9D6yQG7j1EUSjkxb
        +4ebrcrc3Znbvvjv1rNT29Dugq6FH5A4a8gM8CmT6hr8KUwvZPXjrMrAKBK53msZmPjhnFvHn2WkZ
        x80Dt3WM+FAShlSx44RIinSrAfbJEaV5H0B9WpJGfxTAsZnKc/mOkky6ACxDtd4XF4GGsIY0vaIsn
        m7RkFTIS2b6UIk8wz9KNPNebJRl28+/evRKyqHKXstnknH1dR5kpyUFDAEyA9VTP4X44ZJiIayOAf
        451yDgQw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4l5O-0003xf-4U; Thu, 20 Feb 2020 12:37:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB2F6300565;
        Thu, 20 Feb 2020 13:35:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EAAA2B4D9BC7; Thu, 20 Feb 2020 13:37:42 +0100 (CET)
Date:   Thu, 20 Feb 2020 13:37:42 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, luto@kernel.org, tony.luck@intel.com,
        frederic@kernel.org, dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200220123742.GZ18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
 <20200219155715.GD14946@hirez.programming.kicks-ass.net>
 <20200220121727.GB507@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220121727.GB507@zn.tnic>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 20, 2020 at 01:17:27PM +0100, Borislav Petkov wrote:
> On Wed, Feb 19, 2020 at 04:57:15PM +0100, Peter Zijlstra wrote:
> > -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> > +		for (i = 0; i < count; i++) {
> > +			int idx = (dst <= src) ? i : count - i;
> > +			dst[idx] = src[idx];
> > +		}
> 
> Or, you can actually unroll it. This way it even documents clearly what
> it does:
> 
> diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> index fe38015ed50a..2b790a574ba5 100644
> --- a/arch/x86/kernel/traps.c
> +++ b/arch/x86/kernel/traps.c
> @@ -298,6 +298,7 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
>  		regs->ip == (unsigned long)native_irq_return_iret)
>  	{
>  		struct pt_regs *gpregs = (struct pt_regs *)this_cpu_read(cpu_tss_rw.x86_tss.sp0) - 1;
> +		unsigned long *p = (unsigned long *)regs->sp;
>  
>  		/*
>  		 * regs->sp points to the failing IRET frame on the
> @@ -305,7 +306,11 @@ dotraplinkage void do_double_fault(struct pt_regs *regs, long error_code, unsign
>  		 * in gpregs->ss through gpregs->ip.
>  		 *
>  		 */
> -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> +		gpregs->ip	= *p;
> +		gpregs->cs	= *(p + 1);
> +		gpregs->flags	= *(p + 2);
> +		gpregs->sp	= *(p + 3);
> +		gpregs->ss	= *(p + 4);
>  		gpregs->orig_ax = 0;  /* Missing (lost) #GP error code */
>  
>  		/*

While I love that; is that actually correct? This is an unroll of
memcpy() not memmove(). IFF the ranges overlap, the above is buggered.

Was the original memmove() really needed?

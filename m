Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE3FA16FFBB
	for <lists+linux-arch@lfdr.de>; Wed, 26 Feb 2020 14:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBZNQx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 Feb 2020 08:16:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:39704 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgBZNQx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 Feb 2020 08:16:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dBTEGeYdwOYe1m9MR0swroLBpZXLyk3mtt8wrgV6Ovc=; b=cGWoguhwhW+FQQ8dKZd+JTjhwk
        BRfx7XVWuUB3DRzatCE2HAGxCVK+FemfvM1wF1N+9NIC+q4PoQWoRPcoHgwNduhGIZ6xv6CTSVclb
        mP7JT/nGL1GrjHsOc6cW+4wlxVp6/qkWJrW7kCOIbRmyRGol6ScP038NpnPreUqhzlRXsdT833EsH
        phK31L0UPA5dN8aerwDKGwFEvJ2iu4xSAtdLMFiXgS+1I2dGE672cOmb+b1mjTgL8XiPTSVS/XQE1
        iPiwD/y15qhQDPs+tbK45pOqqTnbXYJHKamMcMfe3p5rYAbSZ4F2bPZepE4nxOP4DczXqKdlPfJfg
        R/SxhgAA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6wXq-0005Pn-4i; Wed, 26 Feb 2020 13:16:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AF5E300130;
        Wed, 26 Feb 2020 14:14:11 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8FC282B264902; Wed, 26 Feb 2020 14:16:06 +0100 (CET)
Date:   Wed, 26 Feb 2020 14:16:06 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
Message-ID: <20200226131606.GL14946@hirez.programming.kicks-ass.net>
References: <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
 <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
 <20200224112708.4f307ba3@gandalf.local.home>
 <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
 <20200224114754.0fb798c1@gandalf.local.home>
 <20200224213139.GO11457@worktop.programming.kicks-ass.net>
 <20200224170231.3807931d@gandalf.local.home>
 <20200226102509.GU18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226102509.GU18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 26, 2020 at 11:25:09AM +0100, Peter Zijlstra wrote:
> Subject: sh/ftrace: Move arch_ftrace_nmi_{enter,exit} into nmi exception
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Feb 24 22:26:21 CET 2020
> 
> SuperH is the last remaining user of arch_ftrace_nmi_{enter,exit}(),
> remove it from the generic code and into the SuperH code.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---

> --- a/arch/sh/kernel/traps.c
> +++ b/arch/sh/kernel/traps.c
> @@ -170,11 +170,21 @@ BUILD_TRAP_HANDLER(bug)
>  	force_sig(SIGTRAP);
>  }
>  
> +#ifdef CONFIG_HAVE_DYNAMIC_FTRACE

build robot just informed me that this ought to s/HAVE_//

> +extern void arch_ftrace_nmi_enter(void);
> +extern void arch_ftrace_nmi_exit(void);
> +#else
> +static inline void arch_ftrace_nmi_enter(void) { }
> +static inline void arch_ftrace_nmi_exit(void) { }
> +#endif

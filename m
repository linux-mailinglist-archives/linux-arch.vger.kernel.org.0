Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E34631648A6
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 16:31:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbgBSPba (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 10:31:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:41066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726664AbgBSPba (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 10:31:30 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1484A24654;
        Wed, 19 Feb 2020 15:31:28 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:31:26 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, paulmck@kernel.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH v3 01/22] hardirq/nmi: Allow nested nmi_enter()
Message-ID: <20200219103126.33f67cf3@gandalf.local.home>
In-Reply-To: <20200219150744.428764577@infradead.org>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.428764577@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 15:47:25 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> Since there are already a number of sites (ARM64, PowerPC) that
> effectively nest nmi_enter(), lets make the primitive support this
> before adding even more.
> 


>  void SMIException(struct pt_regs *regs)
> --- a/include/linux/hardirq.h
> +++ b/include/linux/hardirq.h
> @@ -71,7 +71,7 @@ extern void irq_exit(void);
>  		printk_nmi_enter();				\
>  		lockdep_off();					\
>  		ftrace_nmi_enter();				\
> -		BUG_ON(in_nmi());				\
> +		BUG_ON(in_nmi() == NMI_MASK);			\
>  		preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
>  		rcu_nmi_enter();				\
>  		trace_hardirq_enter();				\
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -26,13 +26,13 @@
>   *         PREEMPT_MASK:	0x000000ff
>   *         SOFTIRQ_MASK:	0x0000ff00
>   *         HARDIRQ_MASK:	0x000f0000
> - *             NMI_MASK:	0x00100000
> + *             NMI_MASK:	0x00f00000
>   * PREEMPT_NEED_RESCHED:	0x80000000
>   */
>  #define PREEMPT_BITS	8
>  #define SOFTIRQ_BITS	8
>  #define HARDIRQ_BITS	4
> -#define NMI_BITS	1
> +#define NMI_BITS	4
>  

Probably should document somewhere (in a comment above nmi_enter()?)
that we allow nmi_enter() to nest up to 15 times.

-- Steve

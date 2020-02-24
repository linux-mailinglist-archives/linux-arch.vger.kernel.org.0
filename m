Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41EFB16ABB1
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 17:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgBXQee (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 11:34:34 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:34964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727299AbgBXQee (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Feb 2020 11:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9yl3DP9ucs4uObZLy5iqNZp2w5Oe3v/bojnGtEYlbQ=; b=MXxp49h1d8mC9C7ommRJDgNBg2
        wpKAI81DLo1i64lQCugUzdwQycxvzgFZ6U1ieomQy7t/y+0i/eg9+QGcWjdlFUVTwTsZ+loAjfQL9
        kwA2oeX/gkS4E3vhclr++JkVYwPasd1TuYViTEC3VX6pDL9S6CDzlcJT5ynjNFl5Q6clD8NilTrdT
        qErRR5aXXXwqXAlyuMPvlf8MFKRNHaXd3mRCYW0/UUGAg96OJGYEQw73S22k3Xx75P/Yp2pfoBi6u
        UApcmr/PU89uYMAqBLAEJi3+2vGbUpGhKGlDQW5GtMNxRBVH8FwpQzEczySgu8VoBekplb1p45twD
        VkCVDaGg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6GgN-0003n0-S5; Mon, 24 Feb 2020 16:34:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4C6C6305EFE;
        Mon, 24 Feb 2020 17:32:15 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CA7B4202BD153; Mon, 24 Feb 2020 17:34:09 +0100 (CET)
Date:   Mon, 24 Feb 2020 17:34:09 +0100
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
Message-ID: <20200224163409.GJ18400@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
 <20200221202246.GA14897@hirez.programming.kicks-ass.net>
 <20200224104346.GJ14946@hirez.programming.kicks-ass.net>
 <20200224112708.4f307ba3@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224112708.4f307ba3@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 24, 2020 at 11:27:08AM -0500, Steven Rostedt wrote:
> On Mon, 24 Feb 2020 11:43:46 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > -dotraplinkage void notrace do_int3(struct pt_regs *regs, long error_code)
> > +dotraplinkage notrace void do_int3(struct pt_regs *regs, long error_code)
> >  {
> >  	if (poke_int3_handler(regs))
> >  		return;
> >  
> >  	/*
> > -	 * Use ist_enter despite the fact that we don't use an IST stack.
> > -	 * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> > -	 * mode or even during context tracking state changes.
> > -	 *
> > -	 * This means that we can't schedule.  That's okay.
> > +	 * Unlike any other non-IST entry, we can be called from pretty much
> > +	 * any location in the kernel through kprobes -- text_poke() will most
> > +	 * likely be handled by poke_int3_handler() above. This means this
> > +	 * handler is effectively NMI-like.
> >  	 */
> > -	ist_enter(regs);
> > +	nmi_enter();
> 
> Hmm, note that nmi_enter() calls other functions. Did you make sure
> all of them are not able to be kprobed. This is different than just
> being "NMI like", it's that if they are kprobed, then this will go into
> an infinite loop because nothing can have a kprobe before the kprobe
> int3 handler is called here.

I did not audit that; I went with the fact that hitting kprobes before
in_nmi() is true is a bug.

Looking at nmi_enter(), that leaves trace_hardirq_enter(), since we know
we marked rcu_nmi_enter() as NOKPROBES, per the patches elsewhere in
this series.

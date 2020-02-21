Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB7CE168849
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 21:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBUUXQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 15:23:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40184 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbgBUUXP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 15:23:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9eah5mmtKLlA+R3XKIogLnPb4pPWtnReB1crMdBWtYc=; b=glnyFpsYL1aEqrd70xvIyYQzNb
        9tfkpuBvQHr6ir6X/Bv877cfG0gKuxQp7ihwG56BqSZYKGuYrdivuD3j/wnNato2VV9WpqTQ4MGI9
        oITRq7eJ21VtURkWM3MmhRkXIQpXa8C/7Dq2i3D9dq5EHLsUmB+xDsrRy4z+0PXCQZOKeO1rozvUQ
        UTTDIU33rVEsl4l6PSrhdHs8/0SauKfDyJ3Gntc1lNjxH15+G2uNx004rB6EowNvADQCujEvx5FVe
        pK4hq9+IfPfdk8iWu64vzKrVDvEYgmrKaV4eQrlo/8Fw+ROqKffUO3T61YMKU9f/ALCXanZmh7wa8
        Ggn3EtDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5Ep0-0002E7-Dq; Fri, 21 Feb 2020 20:22:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D7C4130008D;
        Fri, 21 Feb 2020 21:20:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9CE7D209DB0F7; Fri, 21 Feb 2020 21:22:46 +0100 (CET)
Date:   Fri, 21 Feb 2020 21:22:46 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
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
Message-ID: <20200221202246.GA14897@hirez.programming.kicks-ass.net>
References: <20200221133416.777099322@infradead.org>
 <20200221134215.328642621@infradead.org>
 <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrU7nezN7d3GEZ8h8HbRfvZ0+F9+Ahb7fLvZ9FVaHN9x2w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 11:05:36AM -0800, Andy Lutomirski wrote:

> > -       /*
> > -        * Use ist_enter despite the fact that we don't use an IST stack.
> > -        * We can be called from a kprobe in non-CONTEXT_KERNEL kernel
> > -        * mode or even during context tracking state changes.
> > -        *
> > -        * This means that we can't schedule.  That's okay.
> > -        */
> > -       ist_enter(regs);
> > +       nmi_enter();
> 
> I agree with the change, but some commentary might be nice.  Maybe
> copy from here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/commit/?h=x86/idtentry&id=061eaa900b4f63601ab6381ab431fcef8dfd84be

Fair enough; I'll add something to #DB and #BP for that.

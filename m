Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACD9164A7F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726717AbgBSQex (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:34:53 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQex (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:34:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=62TjyVa62kJevaUKWTJbXR7eSfDQzwN1RJE2fVf8wH4=; b=Po02hHzgZy6lDFy6gBm6LhZm/U
        ymRfkKXwbzlVv0iPoEgZjw03kSVYDaKQi4h4NZhdP0dSNyFgV5KF/lzyedKr2ik7UiQT2PpM71vu2
        aTRYNqavF0vE5zsuDvxsUeFr5Fl8sgQ/0c/pjiNYlnDSgu58zvmrt/q/5dhogLBPNYYZWYdrd9oPn
        g1xJrv6kjHKlRr9qWmEaknUa9Vh44lHiW3k/QpxtUEUooV5IqydPMR3wqXPn+2xlt8txUurGJqOQU
        e0bi1K01HLT3JUz1YX+JIPGc0IdUdwxuiFPYn2vSdzuBcMtKIesZfGc/zV26BfLhcs1hY2pZiP6F8
        eT0Hgh0Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SIe-0000wd-Ao; Wed, 19 Feb 2020 16:34:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D67F4300606;
        Wed, 19 Feb 2020 17:32:16 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 459D2201BADC1; Wed, 19 Feb 2020 17:34:09 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:34:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, mingo@kernel.org,
        joel@joelfernandes.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 04/22] x86/doublefault: Make memmove() notrace/NOKPROBE
Message-ID: <20200219163409.GI18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.604459293@infradead.org>
 <20200219103614.2299ff61@gandalf.local.home>
 <20200219154031.GE18400@hirez.programming.kicks-ass.net>
 <20200219155715.GD14946@hirez.programming.kicks-ass.net>
 <20200219160442.GE14946@hirez.programming.kicks-ass.net>
 <20200219111228.44c2999b@gandalf.local.home>
 <20200219162747.GX2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219162747.GX2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 08:27:47AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 11:12:28AM -0500, Steven Rostedt wrote:
> > On Wed, 19 Feb 2020 17:04:42 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > > > -		memmove(&gpregs->ip, (void *)regs->sp, 5*8);
> > > > +		for (i = 0; i < count; i++) {
> > > > +			int idx = (dst <= src) ? i : count - i;  
> > > 
> > > That's an off-by-one for going backward; 'count - 1 - i' should work
> > > better, or I should just stop typing for today ;-)
> > 
> > Or, we could just cut and paste the current memmove and make a notrace
> > version too. Then we don't need to worry bout bugs like this.
> 
> OK, I will bite...
> 
> Can we just make the core be an inline function and make a notrace and
> a trace caller?  Possibly going one step further and having one call
> the other?  (Presumably the traceable version invoking the notrace
> version, but it has been one good long time since I have looked at
> function preambles.)

One complication is that GCC (and others) are prone to stick their own
implementation of memmove() (and other string functions) in at 'random'.
That is, it is up to the compiler's discretion wether or not to put a
call to memmove() in or just emit some random giberish they feel has the
same effect.

So if we go play silly games like that, we need be careful (or just call
__memmove I suppose, which is supposed to avoid that IIRC).

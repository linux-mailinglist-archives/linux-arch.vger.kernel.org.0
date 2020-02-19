Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDBF1164BF8
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgBSReY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:34:24 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45108 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726551AbgBSReX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 12:34:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2P6Ws3RkPs8vzqQG8mBEIrnxkKqiE7dFwfIH2EVwUnM=; b=Hm0Lw1D/oQlx5O9Z44lRzvi5i8
        S7PAX5z1ivDMlBCEzoFGozFeX3weNrthcgfVSCgrujqySa7S5ILzS99tXV3qmb5XnbtVDAl5o7sTO
        vlQut+G4rrX56/uxzmOieWFDhKeMKlIbbXZIi13WJOY9YhKZ3qe1xglpRgCHlG7BH9XjaID4EyqlT
        m+LHNOCydRn8YIQLbGVJLrrnI3ztmILiahomJvR14ECSwBi14a8eIMq5WpNpHg5064/qbkUcXxd84
        gX+4BVkGJXSKhaCOhhyWdnd9Hdra/uga2t0UhyWOTY+Vmbzq9bPSbc+yYJ2eTfud/J+xf5axEDerH
        G7FUaDNA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4TEW-0002wP-Tq; Wed, 19 Feb 2020 17:34:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DE66A300565;
        Wed, 19 Feb 2020 18:32:05 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 520CF202287CB; Wed, 19 Feb 2020 18:33:58 +0100 (CET)
Date:   Wed, 19 Feb 2020 18:33:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
Message-ID: <20200219173358.GP18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.488895196@infradead.org>
 <20200219171309.GC32346@zn.tnic>
 <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrWBEDjenqze3wVc6TkUt_g+OFx9TQbYysLH+6fku=aWjQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 09:21:48AM -0800, Andy Lutomirski wrote:
> On Wed, Feb 19, 2020 at 9:13 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Wed, Feb 19, 2020 at 03:47:26PM +0100, Peter Zijlstra wrote:
> > > Subject: Re: [PATCH v3 02/22] x86,mce: Delete ist_begin_non_atomic()
> >
> > x86/mce: ...
> >
> > > It is an abomination; and in prepration of removing the whole
> > > ist_enter() thing, it needs to go.
> > >
> > > Convert #MC over to using task_work_add() instead; it will run the
> > > same code slightly later, on the return to user path of the same
> > > exception.
> >
> > That's fine because the error happened in userspace.
> 
> Unless there is a signal pending and the signal setup code is about to
> hit the same failed memory.  I suppose we can just treat cases like
> this as "oh well, time to kill the whole system".
> 
> But we should genuinely agree that we're okay with deferring this handling.

It doesn't delay much. The moment it does that local_irq_enable() it's
subject to preemption, just like it is on the return to user path.

Do you really want to create code that unwinds enough of nmi_enter() to
get you to a preemptible context? *shudder*

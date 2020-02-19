Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB30164AD9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:45:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgBSQpq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:45:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726551AbgBSQpq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 11:45:46 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19ABC20578;
        Wed, 19 Feb 2020 16:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582130745;
        bh=IzfEf9eLgE8F8pz7bfZaRUiusn9TiUNKDkI24ysHkws=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=WWTQfPoT/JtbsiGP5ir+kOvBjroYp/fwaJOLdZbaMN+eRfLzyccwpKnifAX/SqHhd
         S6p1ewPDPPRGcSEoOj9bc6ffImeJhEFOc5YHzk1FDa5aAjhPoKF7ZMNPqKt6ir2N+/
         Gj9JvXKfxxlNxWfPdo4PbWZnBGTt0QpnRhPcXUFg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id ECCC335209B0; Wed, 19 Feb 2020 08:45:44 -0800 (PST)
Date:   Wed, 19 Feb 2020 08:45:44 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 05/22] rcu: Make RCU IRQ enter/exit functions rely on
 in_nmi()
Message-ID: <20200219164544.GD2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72>
 <20200219163700.GK18400@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163700.GK18400@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 05:37:00PM +0100, Peter Zijlstra wrote:
> On Wed, Feb 19, 2020 at 08:31:56AM -0800, Paul E. McKenney wrote:
> > On Wed, Feb 19, 2020 at 03:47:29PM +0100, Peter Zijlstra wrote:
> > > From: Paul E. McKenney <paulmck@kernel.org>
> > > 
> > > The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> > > "irq" parameter that indicates whether these functions are invoked from
> > > an irq handler (irq==true) or an NMI handler (irq==false).  However,
> > > recent changes have applied notrace to a few critical functions such
> > > that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> > > on in_nmi().  Note that in_nmi() works no differently than before,
> > > but rather that tracing is now prohibited in code regions where in_nmi()
> > > would incorrectly report NMI state.
> > > 
> > > This commit therefore removes the "irq" parameter and inlines
> > > rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
> > > and rcu_nmi_exit(), respectively.
> > > 
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > Again, thank you.
> > 
> > Would you like to also take the added comment for NOKPROBE_SYMBOL(),
> > or would you prefer that I carry that separately?  (I dropped it for
> > now to avoid the conflict with the patch below.)
> > 
> > Here is the latest version of that comment, posted by Steve Rostedt.
> > 
> > 							Thanx, Paul
> > 
> > /*
> >  * All functions called in the breakpoint trap handler (e.g. do_int3()
> >  * on x86), must not allow kprobes until the kprobe breakpoint handler
> >  * is called, otherwise it can cause an infinite recursion.
> >  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> >  * before the kprobe breakpoint handler is called, thus it must be
> >  * marked as NOKPROBE.
> >  */
> 
> Oh right, let me stick that in a separate patch. Best we not loose that
> I suppose ;-)

There was a lot of effort spent on it, to be sure.  ;-) ;-) ;-)

							Thanx, Paul

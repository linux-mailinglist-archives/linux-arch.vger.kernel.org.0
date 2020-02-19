Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E488164A9B
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 17:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgBSQh3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 11:37:29 -0500
Received: from merlin.infradead.org ([205.233.59.134]:33404 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgBSQh3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 19 Feb 2020 11:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ATFMy7Dum3060ZAyi2NRjS1WAIXLYlwbWtyija4Q0rE=; b=FE/HzTIWk+zXHj0cI9IFhC+X4j
        IWC0J0zgnd27I6HNEbSnLSVnyRGZZmkiIstwRTUQdEmwu/Olwq8Ut9Tjv0o4+mGJgISsdPs3RNWgB
        SrrZkpyhB2ODFlBFMF6J0PUXmb8R7hPNzndre4+tYSXElbn4CEMYes4KLwvdBZxRyFm4+EPNk8A3N
        X/9yJEvPajo9IUhrsYFmglojOZrHjlYAP4aBv0XFK4IdgyFoSMQZKKBGEq4Pp6Ctvc4+CvXI5uQlz
        FLGuU/IUWFenkzx0S8dp+rsqyK9lK0kMY9swJlN3T9U4RsbCuA9CUOxV7GUQUsyEToyC0Gq/ehXob
        96+qymlw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4SLO-0000zm-CI; Wed, 19 Feb 2020 16:37:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7D7F3300606;
        Wed, 19 Feb 2020 17:35:08 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E51122B9553C1; Wed, 19 Feb 2020 17:37:00 +0100 (CET)
Date:   Wed, 19 Feb 2020 17:37:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH v3 05/22] rcu: Make RCU IRQ enter/exit functions rely on
 in_nmi()
Message-ID: <20200219163700.GK18400@hirez.programming.kicks-ass.net>
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219163156.GY2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 08:31:56AM -0800, Paul E. McKenney wrote:
> On Wed, Feb 19, 2020 at 03:47:29PM +0100, Peter Zijlstra wrote:
> > From: Paul E. McKenney <paulmck@kernel.org>
> > 
> > The rcu_nmi_enter_common() and rcu_nmi_exit_common() functions take an
> > "irq" parameter that indicates whether these functions are invoked from
> > an irq handler (irq==true) or an NMI handler (irq==false).  However,
> > recent changes have applied notrace to a few critical functions such
> > that rcu_nmi_enter_common() and rcu_nmi_exit_common() many now rely
> > on in_nmi().  Note that in_nmi() works no differently than before,
> > but rather that tracing is now prohibited in code regions where in_nmi()
> > would incorrectly report NMI state.
> > 
> > This commit therefore removes the "irq" parameter and inlines
> > rcu_nmi_enter_common() and rcu_nmi_exit_common() into rcu_nmi_enter()
> > and rcu_nmi_exit(), respectively.
> > 
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> Again, thank you.
> 
> Would you like to also take the added comment for NOKPROBE_SYMBOL(),
> or would you prefer that I carry that separately?  (I dropped it for
> now to avoid the conflict with the patch below.)
> 
> Here is the latest version of that comment, posted by Steve Rostedt.
> 
> 							Thanx, Paul
> 
> /*
>  * All functions called in the breakpoint trap handler (e.g. do_int3()
>  * on x86), must not allow kprobes until the kprobe breakpoint handler
>  * is called, otherwise it can cause an infinite recursion.
>  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
>  * before the kprobe breakpoint handler is called, thus it must be
>  * marked as NOKPROBE.
>  */

Oh right, let me stick that in a separate patch. Best we not loose that
I suppose ;-)

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 344A8163A68
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 03:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbgBSCpR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 21:45:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727187AbgBSCpR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 21:45:17 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 221B624654;
        Wed, 19 Feb 2020 02:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582080316;
        bh=5uEBsRxClyuvVqGJzio9egBbCPvJMHgtyV3IoADzuMs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NWCPon5+OMi/0Ypox5wjReXfI94UJLME8bzLQrf1B8AAVbTpkXX/mbUwacXbYo58f
         MEgBLK/qqo4PPxjRi3sWOkO+njPGKfTNBF457tpkLDzd3NwEojC1zic3JLIkY8F/J0
         GMbFa+acEz94szuHDiqbstsd22rR/UZV2VD4SyrE=
Date:   Wed, 19 Feb 2020 11:45:10 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     paulmck@kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-Id: <20200219114510.6f942b56868a97e06352738c@kernel.org>
In-Reply-To: <20200218201806.GI2935@paulmck-ThinkPad-P72>
References: <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
        <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
        <20200217163112.GM2935@paulmck-ThinkPad-P72>
        <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
        <20200218124609.1a33f868@gandalf.local.home>
        <20200218201806.GI2935@paulmck-ThinkPad-P72>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Feb 2020 12:18:06 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> On Tue, Feb 18, 2020 at 12:46:09PM -0500, Steven Rostedt wrote:
> > On Tue, 18 Feb 2020 13:33:35 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> > 
> > > On Mon, 17 Feb 2020 08:31:12 -0800
> > > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > > >   
> > > > > BTW, if you consider the x86 specific code is in the generic file,
> > > > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > > > > (Sorry, I've hit this idea right now)  
> > > > 
> > > > Might this affect other architectures with NMIs and probe-like things?
> > > > If so, it might make sense to leave it where it is.  
> > > 
> > > Yes, git grep shows that arm64 is using rcu_nmi_enter() in
> > > debug_exception_enter().
> > > OK, let's keep it, but maybe it is good to update the comment for
> > > arm64 too. What about following?
> > > 
> > > +/*
> > > + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
> > > + * marked NOKPROBE before kprobes handler is called.
> > > + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
> > > + * before kprobes handle happens to call rcu_nmi_enter() which means
> > > + * that rcu_nmi_enter() must be marked NOKRPOBE.
> > > + */
> > > 
> > 
> > Ah, why don't we just say...
> > 
> > /*
> >  * All functions called in the breakpoint trap handler (e.g. do_int3()
> >  * on x86), must not allow kprobes until the kprobe breakpoint handler
> >  * is called, otherwise it can cause an infinite recursion.
> >  * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> >  * before the kprobe breakpoint handler is called, thus it must be
> >  * marked as NOKPROBE.
> >  */
> > 
> > And that way we don't make this an arch specific comment.
> 
> That looks good to me.  Masami, does this work for you?

Yes, that looks good to me too :)

Thank you!


-- 
Masami Hiramatsu <mhiramat@kernel.org>

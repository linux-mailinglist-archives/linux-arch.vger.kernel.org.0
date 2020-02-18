Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A896162D50
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 18:46:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRRqM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 12:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:32942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRRqM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 12:46:12 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D30E20679;
        Tue, 18 Feb 2020 17:46:10 +0000 (UTC)
Date:   Tue, 18 Feb 2020 12:46:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     paulmck@kernel.org, Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200218124609.1a33f868@gandalf.local.home>
In-Reply-To: <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
References: <20200213204444.GA94647@google.com>
        <20200213205442.GK2935@paulmck-ThinkPad-P72>
        <20200213211930.GG170680@google.com>
        <20200213163800.5c51a5f1@gandalf.local.home>
        <20200213215004.GM2935@paulmck-ThinkPad-P72>
        <20200213170451.690c4e5c@gandalf.local.home>
        <20200213223918.GN2935@paulmck-ThinkPad-P72>
        <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
        <20200215145934.GD2935@paulmck-ThinkPad-P72>
        <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
        <20200217163112.GM2935@paulmck-ThinkPad-P72>
        <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 18 Feb 2020 13:33:35 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Mon, 17 Feb 2020 08:31:12 -0800
> "Paul E. McKenney" <paulmck@kernel.org> wrote:
> >   
> > > BTW, if you consider the x86 specific code is in the generic file,
> > > we can move NOKPROBE_SYMBOL() in arch/x86/kernel/traps.c.
> > > (Sorry, I've hit this idea right now)  
> > 
> > Might this affect other architectures with NMIs and probe-like things?
> > If so, it might make sense to leave it where it is.  
> 
> Yes, git grep shows that arm64 is using rcu_nmi_enter() in
> debug_exception_enter().
> OK, let's keep it, but maybe it is good to update the comment for
> arm64 too. What about following?
> 
> +/*
> + * All functions in do_int3() on x86, do_debug_exception() on arm64 must be
> + * marked NOKPROBE before kprobes handler is called.
> + * ist_enter() on x86 and debug_exception_enter() on arm64 which is called
> + * before kprobes handle happens to call rcu_nmi_enter() which means
> + * that rcu_nmi_enter() must be marked NOKRPOBE.
> + */
> 

Ah, why don't we just say...

/*
 * All functions called in the breakpoint trap handler (e.g. do_int3()
 * on x86), must not allow kprobes until the kprobe breakpoint handler
 * is called, otherwise it can cause an infinite recursion.
 * On some archs, rcu_nmi_enter() is called in the breakpoint handler
 * before the kprobe breakpoint handler is called, thus it must be
 * marked as NOKPROBE.
 */

And that way we don't make this an arch specific comment.

-- Steve

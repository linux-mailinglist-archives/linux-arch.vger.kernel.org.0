Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40175162A21
	for <lists+linux-arch@lfdr.de>; Tue, 18 Feb 2020 17:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgBRQMc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Feb 2020 11:12:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:48756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgBRQMc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 Feb 2020 11:12:32 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EDB821D56;
        Tue, 18 Feb 2020 16:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582042351;
        bh=awLNWgK3jSpoYCcHsbDIpFWZ3TfC+77EIQEyj8YiqW0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0X7a46sIOjECzRz0gSgsb45lVTD4LoFMqM8lAfqw5BBMjeunTIzosKnnh8wvwOgmn
         dw1c7kHiv4rK+byDki53gflxLqjmyJwI0xy2GTrvm88GH9/2CTmZIfyfhZOwUmQG1E
         e9w4sDNTWeU7FtqiUtCsTrU+lkaMLAEg8LsZnMpY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 4A93D3520365; Tue, 18 Feb 2020 08:12:31 -0800 (PST)
Date:   Tue, 18 Feb 2020 08:12:31 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200218161231.GD2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200213211930.GG170680@google.com>
 <20200213163800.5c51a5f1@gandalf.local.home>
 <20200213215004.GM2935@paulmck-ThinkPad-P72>
 <20200213170451.690c4e5c@gandalf.local.home>
 <20200213223918.GN2935@paulmck-ThinkPad-P72>
 <20200214151906.b1354a7ed6b01fc3bf2de862@kernel.org>
 <20200215145934.GD2935@paulmck-ThinkPad-P72>
 <20200217175519.12a694a969c1a8fb2e49905e@kernel.org>
 <20200217163112.GM2935@paulmck-ThinkPad-P72>
 <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218133335.c87d7b2399ee6532bf28b74a@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 18, 2020 at 01:33:35PM +0900, Masami Hiramatsu wrote:
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

Would it work to describe the general problem, then give x86 details
as a specific example, as follows?

/*
 * On some architectures, certain exceptions prohibit use of kprobes until
 * the exception code path reaches a certain point.  For example, on x86 all
 * functions called by do_int3() must be marked NOKPROBE.  However, once
 * kprobe_int3_handler() is called, kprobing is permitted.  Specifically,
 * ist_enter() is called in do_int3() before kprobe_int3_handle().
 * Furthermore, ist_enter() calls rcu_nmi_enter(), which means that
 * rcu_nmi_enter() must be marked NOKRPOBE.
 */

That way, I don't feel like I need to update the commment each time
a new architecture adds this capability.  ;-)

							Thanx, Paul

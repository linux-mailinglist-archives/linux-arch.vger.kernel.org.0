Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00E40165736
	for <lists+linux-arch@lfdr.de>; Thu, 20 Feb 2020 06:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgBTFyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Feb 2020 00:54:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:37316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726027AbgBTFyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 20 Feb 2020 00:54:47 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB75D24654;
        Thu, 20 Feb 2020 05:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582178086;
        bh=LvsVriJkw3pf19LFh682XU7QbdDxbxRUJG7uBnHaKz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uwVyeGpXXCSrzfKJKLPW2cu/SO9nCnY+k5H3NFcLeZeHOZCJjrUHvLmXD2Y4S5gR0
         07aCfpHLo3lQv0fZqr+xDtSybALv/vLkfIyfTPh+zO2Tgs56C1v/vHrDH0+3ZdzaYW
         3tAjafM+8Xy+T2K2CQwXWi4uUpuuSHMX0n/yEp3c=
Date:   Thu, 20 Feb 2020 14:54:39 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH] rcu/kprobes: Comment why rcu_nmi_enter() is marked
 NOKPROBE
Message-Id: <20200220145439.983987683f7d5fd08832d8a1@kernel.org>
In-Reply-To: <20200219121609.45548925@gandalf.local.home>
References: <20200219144724.800607165@infradead.org>
        <20200219150744.661923520@infradead.org>
        <20200219163156.GY2935@paulmck-ThinkPad-P72>
        <20200219121609.45548925@gandalf.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 19 Feb 2020 12:16:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> It's confusing that rcu_nmi_enter() is marked NOKPROBE and
> rcu_nmi_exit() is not. One may think that the exit needs to be marked
> for the same reason the enter is, as rcu_nmi_exit() reverts the RCU
> state back to what it was before rcu_nmi_enter(). But the reason has
> nothing to do with the state of RCU.
> 
> The breakpoint handler (int3 on x86) must not have any kprobe on it
> until the kprobe handler is called. Otherwise, it can cause an infinite
> recursion and crash the machine. It just so happens that
> rcu_nmi_enter() is called by the int3 handler before the kprobe handler
> can run, and therefore needs to be marked as NOKPROBE.
> 
> Comment this to remove the confusion to why rcu_nmi_enter() is marked
> NOKPROBE but rcu_nmi_exit() is not.

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

> 
> Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1694a6b57ad8..ada7b2b638fb 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -846,6 +846,14 @@ void rcu_nmi_enter(void)
>  {
>  	rcu_nmi_enter_common(false);
>  }
> +/*
> + * All functions called in the breakpoint trap handler (e.g. do_int3()
> + * on x86), must not allow kprobes until the kprobe breakpoint handler
> + * is called, otherwise it can cause an infinite recursion.
> + * On some archs, rcu_nmi_enter() is called in the breakpoint handler
> + * before the kprobe breakpoint handler is called, thus it must be
> + * marked as NOKPROBE.
> + */
>  NOKPROBE_SYMBOL(rcu_nmi_enter);
>  
>  /**


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD5F164C43
	for <lists+linux-arch@lfdr.de>; Wed, 19 Feb 2020 18:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgBSRle (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 19 Feb 2020 12:41:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgBSRld (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 19 Feb 2020 12:41:33 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60FE3206DB;
        Wed, 19 Feb 2020 17:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582134093;
        bh=f78D0DzgMOQ4nXGpFv7SQTVZPsx0PXuj05YhnECxSwk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=0tjyZsEBGBUD72akIBBrnwpeH5K2YPMq+llj0c5uKTcFmGH7MZkD/1CSCCNYxbf0P
         3Or1BgnMFPQ16X9FiPi2PeYziWplFcMzga2LGISr3hKsbKayvl+W/3vxxhrL12BngA
         H0HGfBtOt20ra/bGt3Etr/PPnw+cPRXtSHM3CxZw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3D43335209B0; Wed, 19 Feb 2020 09:41:33 -0800 (PST)
Date:   Wed, 19 Feb 2020 09:41:33 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        mingo@kernel.org, joel@joelfernandes.org,
        gregkh@linuxfoundation.org, gustavo@embeddedor.com,
        tglx@linutronix.de, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        luto@kernel.org, tony.luck@intel.com, frederic@kernel.org,
        dan.carpenter@oracle.com, mhiramat@kernel.org
Subject: Re: [PATCH] rcu/kprobes: Comment why rcu_nmi_enter() is marked
 NOKPROBE
Message-ID: <20200219174133.GK2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200219144724.800607165@infradead.org>
 <20200219150744.661923520@infradead.org>
 <20200219163156.GY2935@paulmck-ThinkPad-P72>
 <20200219121609.45548925@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219121609.45548925@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 19, 2020 at 12:16:09PM -0500, Steven Rostedt wrote:
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
> 
> Link: https://lore.kernel.org/r/20200213163800.5c51a5f1@gandalf.local.home
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>

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

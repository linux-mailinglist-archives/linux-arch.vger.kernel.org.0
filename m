Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDF68256410
	for <lists+linux-arch@lfdr.de>; Sat, 29 Aug 2020 04:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgH2CCC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 28 Aug 2020 22:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:60274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgH2CCB (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 28 Aug 2020 22:02:01 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A755220838;
        Sat, 29 Aug 2020 02:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598666521;
        bh=iZMCic1GtmrakuhOaAvefFKOAqHhzVWzyPHatKdXjGU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vAy1j2Dn2Am2fdXasoHFE6RGnv3bGZcpi8BrusVKpbZ/tnyR45ZmKz/sWvNnrx+FM
         Lx9wKB4vDz+L+/ASX7CH2NIQ21FMgIEZ2UTex4K3+0+qNT0Se/oTWJ0u/oW6xaM3Sr
         5OTNiXSxquDx73YG3olI2JT6fc8yuGPXKoPfX+Cc=
Date:   Sat, 29 Aug 2020 11:01:55 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v4 18/23] sched: Fix try_invoke_on_locked_down_task()
 semantics
Message-Id: <20200829110155.70c676520ad2cfef8374171d@kernel.org>
In-Reply-To: <159861779482.992023.8503137488052381952.stgit@devnote2>
References: <159861759775.992023.12553306821235086809.stgit@devnote2>
        <159861779482.992023.8503137488052381952.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 28 Aug 2020 21:29:55 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> From: Peter Zijlstra <peterz@infradead.org>

In the next version I will drop this since I will merge the kretprobe_holder
things into removing kretporbe hash patch.

However, this patch itself seems fixing a bug of commit 2beaf3280e57
("sched/core: Add function to sample state of locked-down task").
Peter, could you push this separately?

Thank you,

> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c |    9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 2d95dc3f4644..13b0db2d0be2 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3006,15 +3006,14 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
>   */
>  bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
>  {
> -	bool ret = false;
>  	struct rq_flags rf;
> +	bool ret = false;
>  	struct rq *rq;
>  
> -	lockdep_assert_irqs_enabled();
> -	raw_spin_lock_irq(&p->pi_lock);
> +	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
>  	if (p->on_rq) {
>  		rq = __task_rq_lock(p, &rf);
> -		if (task_rq(p) == rq)
> +		if (task_rq(p) == rq && rq->curr != p)
>  			ret = func(p, arg);
>  		rq_unlock(rq, &rf);
>  	} else {
> @@ -3028,7 +3027,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
>  				ret = func(p, arg);
>  		}
>  	}
> -	raw_spin_unlock_irq(&p->pi_lock);
> +	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
>  	return ret;
>  }
>  
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

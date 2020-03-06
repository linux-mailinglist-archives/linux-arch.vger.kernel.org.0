Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6710A17C25B
	for <lists+linux-arch@lfdr.de>; Fri,  6 Mar 2020 17:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFQAj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 11:00:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:35056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725935AbgCFQAj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 11:00:39 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57FD62072A;
        Fri,  6 Mar 2020 16:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583510438;
        bh=nbAHA1WahxgO35nO+HhwXLm7RmPwbLsiDfTj5Z3wtuY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXuEwq58XWL66xOdJk0nkgY5LaZFkURF9dB1PupzeUJDfjLHH0IyC5acMAA7SOLXk
         GP+iC/MrX8N0QCe3qoaviZNve1eGKSjkzLpNL5K1dB70vv0XeSxZfeVFVF8wNh9kSs
         2rNH6zagvGemfUaQL+1vPezMgKk3H5vqR1j5QhkI=
Date:   Fri, 6 Mar 2020 17:00:36 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Alex Belits <abelits@marvell.com>
Cc:     "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "linux-mm@vger.kernel.org" <linux-mm@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 03/12] task_isolation: userspace hard isolation from
 kernel
Message-ID: <20200306160035.GD8590@lenoir>
References: <4473787e1b6bc3cc226067e8d122092a678b63de.camel@marvell.com>
 <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36d84b8dd168a38e6a56549dedc15dd6ebf8c09e.camel@marvell.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 04, 2020 at 04:07:12PM +0000, Alex Belits wrote:
> +#ifdef CONFIG_TASK_ISOLATION
> +int try_stop_full_tick(void)
> +{
> +	int cpu = smp_processor_id();
> +	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
> +
> +	/* For an unstable clock, we should return a permanent error code. */
> +	if (atomic_read(&tick_dep_mask) & TICK_DEP_MASK_CLOCK_UNSTABLE)
> +		return -EINVAL;
> +
> +	if (!can_stop_full_tick(cpu, ts))
> +		return -EAGAIN;

Note that the stop_tick naming in nohz can be misleading. It means
we actually leave the periodic mode and we enter in dynamic tick mode.

In practice it means that the tick is delayed until the next event, which
in the worst case may well be in 1 ms and in the best case never. So what
you probably want to check instead is whether the tick has been entirely
stopped (ie: we called hrtimer_cancel(&ts->sched_timer)).

Thanks.

> +
> +	tick_nohz_stop_sched_tick(ts, cpu);
> +	return 0;
> +}
> +#endif
> +
>  static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
>  {
>  	/*
> -- 
> 2.20.1
> 

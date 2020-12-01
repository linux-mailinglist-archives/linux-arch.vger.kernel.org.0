Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12A3B2CA927
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:00:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392187AbgLAQ5o (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:57:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:41940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387876AbgLAQ5o (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:44 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B17992151B;
        Tue,  1 Dec 2020 16:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841823;
        bh=+4ZrlHG5vhlXWRw+9FvtNpOLKhlitTQsHmck6tUTTfc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gB+zf/56lvQEVYhYjfWTh9bKEpDsPjMrBPoFmBRNL61Xf71+qZcHZMyn8HQNFAa40
         MYfNo69z4/mDIlvPx84lFQ5x0qs4WPQFZ8ELrTZySn53jsxlzG/j330EQMGK22Cr9s
         eMkKnw5P8gYhp1f7ja8k5z3nSpebLrqOgVcZmtFA=
Date:   Tue, 1 Dec 2020 16:56:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v4 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201201165656.GE27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-8-will@kernel.org>
 <20201127131916.ncoqmg62dselezyl@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127131916.ncoqmg62dselezyl@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 01:19:16PM +0000, Qais Yousef wrote:
> On 11/24/20 15:50, Will Deacon wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d2003a7d5ab5..818c8f7bdf2a 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1860,24 +1860,18 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> >  }
> >  
> >  /*
> > - * Change a given task's CPU affinity. Migrate the thread to a
> > - * proper CPU and schedule it away if the CPU it's executing on
> > - * is removed from the allowed bitmask.
> > - *
> > - * NOTE: the caller must have a valid reference to the task, the
> > - * task must not exit() & deallocate itself prematurely. The
> > - * call is not atomic; no spinlocks may be held.
> > + * Called with both p->pi_lock and rq->lock held; drops both before returning.
> 
> nit: wouldn't it be better for the caller to acquire and release the locks?
> Not a big deal but it's always confusing when half of the work done outside the
> function and the other half done inside.

That came up in the last version of the patches iirc, but the problem is
that __set_cpus_allowed_ptr_locked() can trigger migration, which can
drop the lock and take another one for the new runqueue.

Given that this function is internal to the scheduler, I think we can
probably live with it.

Will

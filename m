Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 786232CBDD6
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 14:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgLBNHb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 08:07:31 -0500
Received: from foss.arm.com ([217.140.110.172]:38982 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726875AbgLBNHa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 08:07:30 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 404CB30E;
        Wed,  2 Dec 2020 05:06:45 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DF303F718;
        Wed,  2 Dec 2020 05:06:42 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:06:40 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Will Deacon <will@kernel.org>
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
Message-ID: <20201202130640.zg2iijbnxzq2zhu3@e107158-lin.cambridge.arm.com>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-8-will@kernel.org>
 <20201127131916.ncoqmg62dselezyl@e107158-lin.cambridge.arm.com>
 <20201201165656.GE27783@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201165656.GE27783@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 12/01/20 16:56, Will Deacon wrote:
> On Fri, Nov 27, 2020 at 01:19:16PM +0000, Qais Yousef wrote:
> > On 11/24/20 15:50, Will Deacon wrote:
> > 
> > [...]
> > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index d2003a7d5ab5..818c8f7bdf2a 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -1860,24 +1860,18 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
> > >  }
> > >  
> > >  /*
> > > - * Change a given task's CPU affinity. Migrate the thread to a
> > > - * proper CPU and schedule it away if the CPU it's executing on
> > > - * is removed from the allowed bitmask.
> > > - *
> > > - * NOTE: the caller must have a valid reference to the task, the
> > > - * task must not exit() & deallocate itself prematurely. The
> > > - * call is not atomic; no spinlocks may be held.
> > > + * Called with both p->pi_lock and rq->lock held; drops both before returning.
> > 
> > nit: wouldn't it be better for the caller to acquire and release the locks?
> > Not a big deal but it's always confusing when half of the work done outside the
> > function and the other half done inside.
> 
> That came up in the last version of the patches iirc, but the problem is
> that __set_cpus_allowed_ptr_locked() can trigger migration, which can
> drop the lock and take another one for the new runqueue.
> 
> Given that this function is internal to the scheduler, I think we can
> probably live with it.

I guess task_rq_lock() always entails be prepared for surprises!

Works for me.

Thanks

--
Qais Yousef

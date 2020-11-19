Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFA12B984D
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:46:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgKSQll (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:41:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:52756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgKSQll (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 11:41:41 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DA7022220B;
        Thu, 19 Nov 2020 16:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605804100;
        bh=IdNj10e/sr3b3LdQtcOLRRg2JJyeeh5XmiDCYsVk77I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wdqvydQZQ26mI0gT3SQ5VKM5IhdXfEQ8VgwTBlmOBqVHfH0/KPdIOgwcdOGFzH6v1
         /0MGPlofiGzxedOeEeBZz+RuTolxNUXr8TN05c8PqWwG+Y+YvjMckmsHgIOYykIGs2
         mGxx0kU96+vE7hoxIFRJXZZoaaQu2VFmrUe6T4IE=
Date:   Thu, 19 Nov 2020 16:41:33 +0000
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Quentin Perret <qperret@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201119164133.GD4582@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
 <20201119091820.GA2416649@google.com>
 <20201119110549.GA3946@willie-the-truck>
 <jhja6vdwpqc.mognet@arm.com>
 <20201119131301.GD4331@willie-the-truck>
 <jhj7dqhwg5z.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj7dqhwg5z.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 02:54:32PM +0000, Valentin Schneider wrote:
> 
> On 19/11/20 13:13, Will Deacon wrote:
> > On Thu, Nov 19, 2020 at 11:27:55AM +0000, Valentin Schneider wrote:
> >>
> >> On 19/11/20 11:05, Will Deacon wrote:
> >> > On Thu, Nov 19, 2020 at 09:18:20AM +0000, Quentin Perret wrote:
> >> >> > @@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >> >> >             * OK, since we're going to drop the lock immediately
> >> >> >             * afterwards anyway.
> >> >> >             */
> >> >> > -		rq = move_queued_task(rq, &rf, p, dest_cpu);
> >> >> > +		rq = move_queued_task(rq, rf, p, dest_cpu);
> >> >> >    }
> >> >> >  out:
> >> >> > -	task_rq_unlock(rq, p, &rf);
> >> >> > +	task_rq_unlock(rq, p, rf);
> >> >>
> >> >> And that's a little odd to have here no? Can we move it back on the
> >> >> caller's side?
> >> >
> >> > I don't think so, unfortunately. __set_cpus_allowed_ptr_locked() can trigger
> >> > migration, so it can drop the rq lock as part of that and end up relocking a
> >> > new rq, which it also unlocks before returning. Doing the unlock in the
> >> > caller is therfore even weirder, because you'd have to return the lock
> >> > pointer or something horrible like that.
> >> >
> >> > I did add a comment about this right before the function and it's an
> >> > internal function to the scheduler so I think it's ok.
> >> >
> >>
> >> An alternative here would be to add a new SCA_RESTRICT flag for
> >> __set_cpus_allowed_ptr() (see migrate_disable() faff in
> >> tip/sched/core). Not fond of either approaches, but the flag thing would
> >> avoid this "quirk".
> >
> > I tried this when I read about the migrate_disable() stuff on lwn, but I
> > didn't really find it any better to work with tbh. It also doesn't help
> > with the locking that Quentin was mentioning, does it? (i.e. you still
> > have to allocate).
> >
> 
> You could keep it all bundled within __set_cpus_allowed_ptr() (i.e. not
> have a _locked() version) and use the flag as indicator of any extra work.

Ah, gotcha. Still not convinced it's any better, but I see that it works.

> Also FWIW we have this pattern of pre-allocating pcpu cpumasks
> (select_idle_mask, load_balance_mask), but given this is AIUI a
> very-not-hot path, this might be overkill (and reusing an existing one
> would be on the icky side of things).

I think that makes sense for static masks, but since this is dynamic I was
following the lead of sched_setaffinity().

Will

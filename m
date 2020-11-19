Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90972B9100
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgKSL2B (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:28:01 -0500
Received: from foss.arm.com ([217.140.110.172]:53930 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbgKSL2B (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 06:28:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 69D521396;
        Thu, 19 Nov 2020 03:28:00 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 191BA3F718;
        Thu, 19 Nov 2020 03:27:57 -0800 (PST)
References: <20201113093720.21106-1-will@kernel.org> <20201113093720.21106-8-will@kernel.org> <20201119091820.GA2416649@google.com> <20201119110549.GA3946@willie-the-truck>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>
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
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to limit task CPU affinity
In-reply-to: <20201119110549.GA3946@willie-the-truck>
Date:   Thu, 19 Nov 2020 11:27:55 +0000
Message-ID: <jhja6vdwpqc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 19/11/20 11:05, Will Deacon wrote:
> On Thu, Nov 19, 2020 at 09:18:20AM +0000, Quentin Perret wrote:
>> > @@ -1937,20 +1931,69 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>> >             * OK, since we're going to drop the lock immediately
>> >             * afterwards anyway.
>> >             */
>> > -		rq = move_queued_task(rq, &rf, p, dest_cpu);
>> > +		rq = move_queued_task(rq, rf, p, dest_cpu);
>> >    }
>> >  out:
>> > -	task_rq_unlock(rq, p, &rf);
>> > +	task_rq_unlock(rq, p, rf);
>>
>> And that's a little odd to have here no? Can we move it back on the
>> caller's side?
>
> I don't think so, unfortunately. __set_cpus_allowed_ptr_locked() can trigger
> migration, so it can drop the rq lock as part of that and end up relocking a
> new rq, which it also unlocks before returning. Doing the unlock in the
> caller is therfore even weirder, because you'd have to return the lock
> pointer or something horrible like that.
>
> I did add a comment about this right before the function and it's an
> internal function to the scheduler so I think it's ok.
>

An alternative here would be to add a new SCA_RESTRICT flag for
__set_cpus_allowed_ptr() (see migrate_disable() faff in
tip/sched/core). Not fond of either approaches, but the flag thing would
avoid this "quirk".

> Will

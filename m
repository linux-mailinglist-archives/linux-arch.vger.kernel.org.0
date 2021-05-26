Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4086539177F
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 14:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233638AbhEZMia (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 08:38:30 -0400
Received: from foss.arm.com ([217.140.110.172]:43942 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233552AbhEZMiU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 08:38:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81C611516;
        Wed, 26 May 2021 05:36:35 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F21E63F73B;
        Wed, 26 May 2021 05:36:32 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH v7 01/22] sched: Favour predetermined active CPU as migration destination
In-Reply-To: <YK4/6+lX4WJxcLDw@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org> <20210525151432.16875-2-will@kernel.org> <877djlhhmb.mognet@arm.com> <YK4/6+lX4WJxcLDw@hirez.programming.kicks-ass.net>
Date:   Wed, 26 May 2021 13:36:27 +0100
Message-ID: <874kephdtg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 26/05/21 14:32, Peter Zijlstra wrote:
> On Wed, May 26, 2021 at 12:14:20PM +0100, Valentin Schneider wrote:
>> ---
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 5226cc26a095..cd447c9db61d 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>
>> @@ -1954,19 +1953,15 @@ static int migration_cpu_stop(void *data)
>>  		if (pending) {
>>  			p->migration_pending = NULL;
>>  			complete = true;
>>  
>>  			if (cpumask_test_cpu(task_cpu(p), &p->cpus_mask))
>>  				goto out;
>>  		}
>>  
>>  		if (task_on_rq_queued(p))
>> +			rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
>
>> @@ -2249,7 +2244,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>>  			init_completion(&my_pending.done);
>>  			my_pending.arg = (struct migration_arg) {
>>  				.task = p,
>> +				.dest_cpu = dest_cpu,
>>  				.pending = &my_pending,
>>  			};
>>  
>> @@ -2257,6 +2252,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
>>  		} else {
>>  			pending = p->migration_pending;
>>  			refcount_inc(&pending->refs);
>> +			pending->arg.dest_cpu = dest_cpu;
>>  		}
>>  	}
>
> Argh.. that might just work. But I'm thinking we wants comments this
> time around :-) This is even more subtle.

Lemme stare at it some more and sharpen my quill then.

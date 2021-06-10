Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5853A293B
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 12:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhFJKWN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 06:22:13 -0400
Received: from foss.arm.com ([217.140.110.172]:56162 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhFJKWN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 06:22:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AAF67D6E;
        Thu, 10 Jun 2021 03:20:16 -0700 (PDT)
Received: from e113632-lin (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0A2933F694;
        Thu, 10 Jun 2021 03:20:13 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
        kernel-team@android.com, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH v8 06/19] cpuset: Don't use the cpu_possible_mask as a last resort for cgroup v1
In-Reply-To: <20210607172042.GB7650@willie-the-truck>
References: <20210602164719.31777-1-will@kernel.org> <20210602164719.31777-7-will@kernel.org> <877dj9ees8.mognet@arm.com> <20210607172042.GB7650@willie-the-truck>
Date:   Thu, 10 Jun 2021 11:20:09 +0100
Message-ID: <87fsxqc97q.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07/06/21 18:20, Will Deacon wrote:
> On Fri, Jun 04, 2021 at 06:11:03PM +0100, Valentin Schneider wrote:
>> On 02/06/21 17:47, Will Deacon wrote:
>> > @@ -3322,9 +3322,13 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>> >
>> >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>> >  {
>> > +	const struct cpumask *cs_mask;
>> > +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
>> > +
>> >       rcu_read_lock();
>> > -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
>> > -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
>> > +	cs_mask = task_cs(tsk)->cpus_allowed;
>> > +	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
>> > +		do_set_cpus_allowed(tsk, cs_mask);
>>
>> Since the task will still go through the is_cpu_allowed() loop in
>> select_fallback_rq() after this, is the subset check actually required
>> here?
>
> Yes, I think it's needed. do_set_cpus_allowed() doesn't do any checking
> against the task_cpu_possible_mask, so if we returned to
> select_fallback_rq() with a mask containing a mixture of 32-bit-capable and
> 64-bit-only CPUs then we'd end up setting an affinity mask for a 32-bit
> task which contains 64-bit-only cores.
>

Once again, you're right :-)

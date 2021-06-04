Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510C139BE2B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230396AbhFDRM4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 13:12:56 -0400
Received: from foss.arm.com ([217.140.110.172]:43766 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhFDRMz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 4 Jun 2021 13:12:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A081063;
        Fri,  4 Jun 2021 10:11:08 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBB5E3F73D;
        Fri,  4 Jun 2021 10:11:05 -0700 (PDT)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
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
In-Reply-To: <20210602164719.31777-7-will@kernel.org>
References: <20210602164719.31777-1-will@kernel.org> <20210602164719.31777-7-will@kernel.org>
Date:   Fri, 04 Jun 2021 18:11:03 +0100
Message-ID: <877dj9ees8.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 02/06/21 17:47, Will Deacon wrote:
> @@ -3322,9 +3322,13 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
>
>  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
>  {
> +	const struct cpumask *cs_mask;
> +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> +
>       rcu_read_lock();
> -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> +	cs_mask = task_cs(tsk)->cpus_allowed;
> +	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
> +		do_set_cpus_allowed(tsk, cs_mask);

Since the task will still go through the is_cpu_allowed() loop in
select_fallback_rq() after this, is the subset check actually required
here?

It would have more merit if cpuset_cpus_allowed_fallback() returned whether
it actually changed the allowed mask or not, in which case we could branch
either to the is_cpu_allowed() loop (as we do unconditionally now), or to
the 'state == possible' switch case.

>       rcu_read_unlock();
>
>       /*
> --
> 2.32.0.rc0.204.g9fa02ecfa5-goog

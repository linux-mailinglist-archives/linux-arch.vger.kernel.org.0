Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B60C438F440
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbhEXUXH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 16:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233009AbhEXUXG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 16:23:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51BC7611B0;
        Mon, 24 May 2021 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621887698;
        bh=Ymn11eEpKHcjX1SZqD9F7FTWGqIxUhQLp7UIF/O1094=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uwc2iVTLCnyT6n6HdKA3DnNb0Oyzbg7bsovOWk7vRoYJnde/7zApoz4TcXvLOtxDH
         ir+o6/Ou0BnEBnNsNHiaXNZvF+t0HjkaDk7sChT4aEorfLk/TYebrA0ldc8dmb6g1i
         Tb9jHrVMBMUZU0ukEO5+uIJV/+iYqntISmCxtIw73ehiHbVYDxVXQHh0fgeXD9qVNG
         ePf/21Kvy47yF0MF2u+ACqWvFXgBmP/SsglHGyIWv1pv7FgNChLCxIsXQbgDIMgZ3F
         cfuZOqnnCCu9mhcJh/KmRfd2XTO8FRU7o5/UUFqKT/xIDtRYY8rzCpjBQZNFThqhH9
         Sh5MHAlmLWqWA==
Date:   Mon, 24 May 2021 21:21:32 +0100
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
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 07/21] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20210524202131.GB15545@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-8-will@kernel.org>
 <20210521173934.pjcv37j63odtsrp6@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521173934.pjcv37j63odtsrp6@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Qais,

On Fri, May 21, 2021 at 06:39:34PM +0100, Qais Yousef wrote:
> On 05/18/21 10:47, Will Deacon wrote:
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index a945504c0ae7..8c799260a4a2 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3322,9 +3322,17 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> >  
> >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> >  {
> > +	const struct cpumask *cs_mask;
> > +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> > +
> >  	rcu_read_lock();
> > -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> > -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> > +	cs_mask = task_cs(tsk)->cpus_allowed;
> > +
> > +	if (!is_in_v2_mode() || !cpumask_subset(cs_mask, possible_mask))
> > +		goto unlock; /* select_fallback_rq will try harder */
> > +
> > +	do_set_cpus_allowed(tsk, cs_mask);
> 
> Shouldn't we take the intersection with possible_mask like we discussed before?
> 
> 	https://lore.kernel.org/lkml/20201217145954.GA17881@willie-the-truck/

Yes, and that's what the '!cpumask_subset()' check is doing above. Either
we use the valid subset of the cpuset mask (which is the intersection with
the possible mask) or we bail if that set is empty.

Will

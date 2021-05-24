Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2235738F4CA
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhEXVR7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 17:17:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:37652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232960AbhEXVR7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 17:17:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 12A3161411;
        Mon, 24 May 2021 21:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621890991;
        bh=mRnyDFN9b6UZo7ExIpoCS1Ag3C643iFCcpo734zRGCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gv410r2BRUDANSAPKB8ulTCmMz3xgrZs+zFG3qwTKFnj5tX7oM7oEsWRtUuFQjTHw
         KEZdiVT442rky6YopzQxT6EgGAYl/Qx1mNi2G/A+Khc9b5zxmoqGAEvYGpEy+MEeir
         lXZP3q3+POQ8YfUU0G5Ph8ht6iGaN5ckwqJ3x3XYMU/aaafJxK5cbMo7yop6llVmLN
         kP59n1m3Hl0csB/3KZyMrMM7qSgW8GdPFUk3WzXE2OgbuyVnCvbvBzxZ35EUZ/vBif
         4O5GxIlWN0fseWNHD4GuUQwQW2zN0RM3F8Zr6VnZZaKk1OusutexIhpklZJOQeYeT6
         UFlQVspooUKMg==
Date:   Mon, 24 May 2021 22:16:25 +0100
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
Subject: Re: [PATCH v6 11/21] sched: Split the guts of sched_setaffinity()
 into a helper function
Message-ID: <20210524211624.GG15545@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-12-will@kernel.org>
 <20210521164101.lwq5wr4mbb32co6l@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521164101.lwq5wr4mbb32co6l@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 05:41:01PM +0100, Qais Yousef wrote:
> On 05/18/21 10:47, Will Deacon wrote:
> > In preparation for replaying user affinity requests using a saved mask,
> > split sched_setaffinity() up so that the initial task lookup and
> > security checks are only performed when the request is coming directly
> > from userspace.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/sched/core.c | 110 +++++++++++++++++++++++---------------------
> >  1 file changed, 58 insertions(+), 52 deletions(-)
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9512623d5a60..808bbe669a6d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -6788,9 +6788,61 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
> >  	return retval;
> >  }
> >  
> > -long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
> > +static int
> > +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
> >  {
> > +	int retval;
> >  	cpumask_var_t cpus_allowed, new_mask;
> > +
> > +	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
> > +		return -ENOMEM;
> > +
> > +	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL))
> > +		return -ENOMEM;
> 
> Shouldn't we free cpus_allowed first?

Oops, yes. Now fixed.

Thanks,

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D942DD25B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Dec 2020 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbgLQNo6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Dec 2020 08:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727743AbgLQNo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Dec 2020 08:44:58 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7BFC061794;
        Thu, 17 Dec 2020 05:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PSUgMjGGYycqOx3vyY6FuXOiRRnqiDNa6Pk1c4l1KWI=; b=YxG+3RRD1MYgV+RDCSgEC6ciGp
        K2BBSpQ1GABHUDDX2KSxRtpkGa6Lniq/029a1K5qe7aqoKSUiqVQIrDMFHeex9Eb+VWl8ZFkhq3Rc
        dBfhRscbF9GpLyjbTHz77NAzY+gyjYLdIFl6ZkZ9wJB83BKVD7rPsyl2xfYStxGUNdcGRtHeav75K
        BqSHyevOOZEyv15Eu7NJxkO2RlhyfvJmzCTJctiH3M8IfNhvEM9yQxbcafKqjsr2P1UMjbde44l/O
        SCzqMIlGW3qqA25m6oZDYYCkgbxFPOQrhTFFSEi/HG4OczMxlkavyoKl7+X5hdzdhwhOJRAOi9Uxl
        mgVwGHEA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kptZb-0002Xs-Og; Thu, 17 Dec 2020 13:44:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BC09F305C11;
        Thu, 17 Dec 2020 14:44:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AA07F201272D1; Thu, 17 Dec 2020 14:44:01 +0100 (CET)
Date:   Thu, 17 Dec 2020 14:44:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v5 07/15] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20201217134401.GY3040@hirez.programming.kicks-ass.net>
References: <20201208132835.6151-1-will@kernel.org>
 <20201208132835.6151-8-will@kernel.org>
 <20201217121552.ds7g2icvqp5nvtha@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217121552.ds7g2icvqp5nvtha@e107158-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 17, 2020 at 12:15:52PM +0000, Qais Yousef wrote:
> On 12/08/20 13:28, Will Deacon wrote:
> > If the scheduler cannot find an allowed CPU for a task,
> > cpuset_cpus_allowed_fallback() will widen the affinity to cpu_possible_mask
> > if cgroup v1 is in use.
> > 
> > In preparation for allowing architectures to provide their own fallback
> > mask, just return early if we're not using cgroup v2 and allow
> > select_fallback_rq() to figure out the mask by itself.
> > 
> > Cc: Li Zefan <lizefan@huawei.com>
> > Cc: Tejun Heo <tj@kernel.org>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Reviewed-by: Quentin Perret <qperret@google.com>
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  kernel/cgroup/cpuset.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
> > index 57b5b5d0a5fd..e970737c3ed2 100644
> > --- a/kernel/cgroup/cpuset.c
> > +++ b/kernel/cgroup/cpuset.c
> > @@ -3299,9 +3299,11 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
> >  
> >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> >  {
> > +	if (!is_in_v2_mode())
> > +		return; /* select_fallback_rq will try harder */
> > +
> >  	rcu_read_lock();
> > -	do_set_cpus_allowed(tsk, is_in_v2_mode() ?
> > -		task_cs(tsk)->cpus_allowed : cpu_possible_mask);
> > +	do_set_cpus_allowed(tsk, task_cs(tsk)->cpus_allowed);
> 
> Why is it safe to return that for cpuset v2?

v1

Because in that case it does cpu_possible_mask, which, if you look at
select_fallback_rq(), is exactly what happens when cpuset 'fails' to
find a candidate.

Or at least, that's how I read the patch.

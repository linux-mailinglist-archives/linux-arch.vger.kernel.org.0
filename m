Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C9838F50E
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbhEXVpY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 17:45:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232693AbhEXVpX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 17:45:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 34A98613F5;
        Mon, 24 May 2021 21:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621892635;
        bh=TbSZnvGZwQBH/lRda1abNy4XGQftqlBj3TmjR9lTeVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TfNrW0WwMMoZd1Oy+m7yRNOWd35YC+C7tzraf73B8ba7aZBnyQwVe6IYvsCUZ6AZT
         4Brl2TDeqHsrF3Jy+RZv76N2BwX/zzUZB9IKkZ47F6Mlp5ceuGMrRz5Wk1UDXH1k81
         vSagh7VHHtoSRM02VBng0GVnYZWVpva5nQojVnlu5UpSFE+0QtZDtT/E3vozsr7KZL
         fnjyknHhd61amw6Z4Ll7h4fxngnsTie1D3fUo/olVn2GLiQdzhTucqO+Qk9OUHcCHY
         bjpXJc6DhFEIZo2zED+6j7P3W0x9LCsB3k+JWo0Am9/vZYN4K5ORK10pBb0aFP6CnY
         NqyHCbcU5gxcg==
Date:   Mon, 24 May 2021 22:43:49 +0100
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
Subject: Re: [PATCH v6 12/21] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <20210524214348.GH15545@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-13-will@kernel.org>
 <20210521171132.ev56j4isuxtf2zqa@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521171132.ev56j4isuxtf2zqa@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 06:11:32PM +0100, Qais Yousef wrote:
> On 05/18/21 10:47, Will Deacon wrote:
> > +static int __set_cpus_allowed_ptr_locked(struct task_struct *p,
> > +					 const struct cpumask *new_mask,
> > +					 u32 flags,
> > +					 struct rq *rq,
> > +					 struct rq_flags *rf)
> > +	__releases(rq->lock)
> > +	__releases(p->pi_lock)
> >  {
> >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> >  	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
> >  	unsigned int dest_cpu;
> > -	struct rq_flags rf;
> > -	struct rq *rq;
> >  	int ret = 0;
> >  
> > -	rq = task_rq_lock(p, &rf);
> >  	update_rq_clock(rq);
> >  
> >  	if (p->flags & PF_KTHREAD || is_migration_disabled(p)) {
> > @@ -2430,20 +2425,158 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  
> >  	__do_set_cpus_allowed(p, new_mask, flags);
> >  
> > -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> > +	if (flags & SCA_USER)
> > +		release_user_cpus_ptr(p);
> 
> Why do we need to release the pointer here?
> 
> Doesn't this mean if a 32bit task requests to change its affinity, then we'll
> lose this info and a subsequent execve() to a 64bit application means we won't
> be able to restore the original mask?
> 
> ie:
> 
> 	p0-64bit
> 	  execve(32bit_app)
> 	    // p1-32bit created
> 	    p1-32bit.change_affinity()
> 	      relase_user_cpus_ptr()
> 	    execve(64bit_app)           // lost info about p0 affinity?
> 
> Hmm I think this helped me to get the answer. p1 changed its affinity, then
> there's nothing to be inherited by a new execve(), so yes we no longer need
> this info.

Yup, you got it.

> > +static int restrict_cpus_allowed_ptr(struct task_struct *p,
> > +				     struct cpumask *new_mask,
> > +				     const struct cpumask *subset_mask)
> > +{
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +	int err;
> > +	struct cpumask *user_mask = NULL;
> > +
> > +	if (!p->user_cpus_ptr)
> > +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> > +
> > +	rq = task_rq_lock(p, &rf);
> > +
> > +	/*
> > +	 * We're about to butcher the task affinity, so keep track of what
> > +	 * the user asked for in case we're able to restore it later on.
> > +	 */
> > +	if (user_mask) {
> > +		cpumask_copy(user_mask, p->cpus_ptr);
> > +		p->user_cpus_ptr = user_mask;
> > +	}
> > +
> > +	/*
> > +	 * Forcefully restricting the affinity of a deadline task is
> > +	 * likely to cause problems, so fail and noisily override the
> > +	 * mask entirely.
> > +	 */
> > +	if (task_has_dl_policy(p) && dl_bandwidth_enabled()) {
> > +		err = -EPERM;
> > +		goto err_unlock;
> 
> free(user_mark) first?
> 
> > +	}
> > +
> > +	if (!cpumask_and(new_mask, &p->cpus_mask, subset_mask)) {
> > +		err = -EINVAL;
> > +		goto err_unlock;
> 
> ditto

We free the mask when the task exits so we don't actually need to clean up
here. I left it like this on the assumption that failing here means that
it's very likely that either the task will exit or retry very soon.

However I agree that it would be clearer to free the thing anyway, so I'll
rejig the code to do that.

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5E73F0210
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhHRK5b (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 06:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234485AbhHRK5b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 18 Aug 2021 06:57:31 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D83C0613CF;
        Wed, 18 Aug 2021 03:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=TemT5VvfEq9NgZ/ksfljExXinLnaxeJbbOKoUEtGfMk=; b=mianM/Y1G8UCXyooNNxC11gvmO
        bh6z/QLqeGIUokBMbi3CLxFWoxKeCE4LUXHEwOjSVuZpTwOllqWjT90lsVqKVQd0BR3xYwd8MXdA2
        VpzLIRBOxOuX/NnBEwoiXsCxrO4Zcx9ZzAIhlUiWWak+767y81hGolHwO3bHZBeCJh5gH6NngVKGd
        0fU5EJyDMxNKDgkLqOSXPb+M27ETb6xlixeRFyW2APtdxaBugltTyutBJrYwgVpLKLHkOOoDQfq7G
        jP/CCJ5aC6JZIlXy34AmPmWn4o07KhBToeWT5JOB57WgjGlACDOfj1qBWNk/XCjbFfEorYdbkNcCm
        Y+0izj5w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGJFS-00AnUG-J9; Wed, 18 Aug 2021 10:56:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8CFEF3012AD;
        Wed, 18 Aug 2021 12:56:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C3882027DC66; Wed, 18 Aug 2021 12:56:41 +0200 (CEST)
Date:   Wed, 18 Aug 2021 12:56:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
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
        Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, kernel-team@android.com
Subject: Re: [PATCH v11 08/16] sched: Allow task CPU affinity to be
 restricted on asymmetric systems
Message-ID: <YRznaZBHXYEzCPt1@hirez.programming.kicks-ass.net>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
 <YRvRfZ/NnuNyIu3s@hirez.programming.kicks-ass.net>
 <20210818104227.GA13828@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818104227.GA13828@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Aug 18, 2021 at 11:42:28AM +0100, Will Deacon wrote:
> As for your other suggestion:
> 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -2733,6 +2733,7 @@ static int __set_cpus_allowed_ptr_locked
> >  	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
> >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> >  	bool kthread = p->flags & PF_KTHREAD;
> > +	struct cpumask *user_mask = NULL;
> >  	unsigned int dest_cpu;
> >  	int ret = 0;
> >  
> > @@ -2792,9 +2793,13 @@ static int __set_cpus_allowed_ptr_locked
> >  	__do_set_cpus_allowed(p, new_mask, flags);
> >  
> >  	if (flags & SCA_USER)
> > -		release_user_cpus_ptr(p);
> > +		swap(user_mask, p->user_cpus_ptr);
> > +
> > +	ret = affine_move_task(rq, p, rf, dest_cpu, flags);
> > +
> > +	kfree(user_mask);
> >  
> > -	return affine_move_task(rq, p, rf, dest_cpu, flags);
> > +	return ret;
> >  
> >  out:
> >  	task_rq_unlock(rq, p, rf);
> > @@ -2954,8 +2959,10 @@ void relax_compatible_cpus_allowed_ptr(s
> >  		return;
> >  
> >  	raw_spin_lock_irqsave(&p->pi_lock, flags);
> > -	release_user_cpus_ptr(p);
> > +	p->user_cpus_ptr = NULL;
> >  	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> > +
> > +	kfree(mask);
> 
> I think the idea looks good, but perhaps we could wrap things up a bit:
> 
> /* Comment about why this is useful with RT */
> static cpumask_t *clear_user_cpus_ptr(struct task_struct *p)
> {
> 	struct cpumask *user_mask = NULL;
> 
> 	swap(user_mask, p->user_cpus_ptr);
> 	return user_mask;
> }
> 
> void release_user_cpus_ptr(struct task_struct *p)
> {
> 	kfree(clear_user_cpus_ptr(p));
> }
> 
> Then just use clear_user_cpus_ptr() in sched/core.c where we know what
> we're doing (well, at least one of us does!).

OK, I'll go make it like that.

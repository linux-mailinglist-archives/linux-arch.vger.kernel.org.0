Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1528391E7C
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 19:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbhEZR6k (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 13:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbhEZR6j (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 May 2021 13:58:39 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9C1C061574;
        Wed, 26 May 2021 10:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dSnlplH+138nPXTWJojZCFoizY/iYF/lvcDTHARd9FQ=; b=mrbjozp92fwTw28bf3Z18/EP1s
        n68GQr+GGZZwHHH3xRBVhBkuR6yJS/PSyEThFUCuVTf+AYVpoPITNfWkVN+8+efr02TxCTpcmM8Qq
        Fz/pIMeZDrKhSk3kKAB5jc8B+HKUHxbMYzgDWBQR3Q2nutcRPQpwtAtmIdigGV0BKIpXE14yxthMK
        QRBEdL7jcXtmLVa5LOZLOiY72DDfqcrUfh2C9KMTS9cnz8ISqVtYGpXj85HNaGscI5SJ4loNXtjVk
        N6bYcKKqfQI/pV7pPmCYv3+vMTzLKIgMoxPMlQnnJZGGqV38LZal1Gse786mkSoMRaOUqPTj2AZcq
        ADE4JmHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1llxlw-000ivJ-Dd; Wed, 26 May 2021 17:56:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0B9B130022C;
        Wed, 26 May 2021 19:56:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E0246201D301D; Wed, 26 May 2021 19:56:51 +0200 (CEST)
Date:   Wed, 26 May 2021 19:56:51 +0200
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
        kernel-team@android.com
Subject: Re: [PATCH v7 10/22] sched: Reject CPU affinity changes based on
 task_cpu_possible_mask()
Message-ID: <YK6L415uk0mCi65f@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-11-will@kernel.org>
 <YK5mJxsmxosX1ciH@hirez.programming.kicks-ass.net>
 <20210526161249.GD19691@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210526161249.GD19691@willie-the-truck>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 05:12:49PM +0100, Will Deacon wrote:
> On Wed, May 26, 2021 at 05:15:51PM +0200, Peter Zijlstra wrote:
> > On Tue, May 25, 2021 at 04:14:20PM +0100, Will Deacon wrote:
> > > Reject explicit requests to change the affinity mask of a task via
> > > set_cpus_allowed_ptr() if the requested mask is not a subset of the
> > > mask returned by task_cpu_possible_mask(). This ensures that the
> > > 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> > > executing it, except in cases where the affinity is forced.
> > > 
> > > Reviewed-by: Quentin Perret <qperret@google.com>
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > > ---
> > >  kernel/sched/core.c | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > > 
> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > index 00ed51528c70..8ca7854747f1 100644
> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -2346,6 +2346,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> > >  				  u32 flags)
> > >  {
> > >  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> > > +	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
> > >  	unsigned int dest_cpu;
> > >  	struct rq_flags rf;
> > >  	struct rq *rq;
> > > @@ -2366,6 +2367,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> > >  		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
> > >  		 */
> > >  		cpu_valid_mask = cpu_online_mask;
> > > +	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
> > > +		ret = -EINVAL;
> > > +		goto out;
> > >  	}
> > 
> > So what about the case where the 32bit task is in-kernel and in
> > migrate-disable ? surely we ought to still validate the new mask against
> > task_cpu_possible_mask.
> 
> That's a good question.
> 
> Given that 32-bit tasks in the kernel are running in 64-bit mode, we can
> actually tolerate them moving around arbitrarily as long as they _never_ try
> to return to userspace on a 64-bit-only CPU. I think this should be the case
> as long as we don't try to return to userspace with migration disabled, no?

Consider:

	8 CPUs, lower 4 have 32bit, higher 4 do not

	A - a 32 bit task		B

	sys_foo()
	  migrate_disable()
	  				sys_sched_setaffinity(A, 0xf0)
					  if (.. | migration_disabled(A))
					    // not checking nothing

					  __do_set_cpus_allowed();

	  migrate_enable()
	    __set_cpus_allowed(SCA_MIGRATE_ENABLE)
	      // frob outselves somewhere in 0xf0
	  sysret
	  *BOOM*


That is, I'm thinking we ought to disallow that sched_setaffinity() with
-EINVAL for 0xf0 has no intersection with 0x0f.

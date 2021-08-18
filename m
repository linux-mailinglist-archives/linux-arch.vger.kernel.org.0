Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4183F01F0
	for <lists+linux-arch@lfdr.de>; Wed, 18 Aug 2021 12:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbhHRKnx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 18 Aug 2021 06:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233733AbhHRKnx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 18 Aug 2021 06:43:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 708C360F58;
        Wed, 18 Aug 2021 10:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629283398;
        bh=K/hTYfaFhnVcaA1kW7ZkYwsbN/b3tTpNGZ+MLUX/kZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXH+p23t2qxHOogRR2wYJ2bYS5u30FIM+pRu5ODKcVUue5PWoK6rwA41qb9SpO7Y1
         feEd8zv8hRtVJgmHYwE7rY0Qi8rpIIDAG45YVKnIj2Ypw/VsHT+MX8n7zISMFNN2fr
         NLnN6oWdj7XtCy9hiFVhuzRfSVnWsTS9E0a51Ts34XZExuqsD2OvZcO82msNhwzjyW
         tvH+c/5pAT8IcYBhKUe2ytPwTwmQ66B65wU+2lKmMHX+4+aPa0o+F3aMh8ipDxJmqJ
         Op8Qoiq2Iw7uMi6D4/hNy1Ks19VoONprw94Vf8v/JJmMsCx+UFwb/yPiGkWeJ7BVLj
         FJXOa/0XEjLaA==
Date:   Wed, 18 Aug 2021 11:43:11 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
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
Message-ID: <20210818104311.GB13828@willie-the-truck>
References: <20210730112443.23245-1-will@kernel.org>
 <20210730112443.23245-9-will@kernel.org>
 <YRvYtlyhuRpFi/Th@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRvYtlyhuRpFi/Th@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 17, 2021 at 05:41:42PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 30, 2021 at 12:24:35PM +0100, Will Deacon wrote:
> > +	struct rq_flags rf;
> > +	struct rq *rq;
> > +	int err;
> > +	struct cpumask *user_mask = NULL;
> 
> > +	cpumask_var_t new_mask;
> > +	const struct cpumask *override_mask = task_cpu_possible_mask(p);
> 
> > +	unsigned long flags;
> > +	struct cpumask *mask = p->user_cpus_ptr;
> 
> I've fixed all that up to be proper reverse x-mas trees; similar for
> other patches.

Thanks.

Will

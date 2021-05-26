Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE198391CB0
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 18:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbhEZQJN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 12:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:60182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235159AbhEZQJM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 12:09:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E5806613D4;
        Wed, 26 May 2021 16:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622045261;
        bh=j6Odz9vOMSnIs4wWXntwTwZIr6CshcRW2BHOShPDJPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rUgCR+uaaXALcZoWRgnnPpHPi975FoacDvb1MOnemnXtnzIJw6OoodjAJogz+f5Hr
         LCGMkt0nePk8Xg4xhmvlzLQuPhuTKQM9nKSUn5tk1XvRbfM20V9tFNWQiS30yKmN0v
         Qs0sM8xsdz0Y697b2/XcH+a/MuIqb7pDKNgNU3Oa9SKJREzdifQfQLrFV6bmUKXh8h
         4UaVu3v1+B+ii8daplbddOL8mGcXICalVn17kYd0tbISr2zvid2Oerh51XYFu6mPk/
         zB3UehjCy0WLcUY63OG/VbtG5QJ6eQx+iauqd6obdjMUBNnBVEkrK7MK1kIVxFhHM+
         /VhhB7JDtKP8g==
Date:   Wed, 26 May 2021 17:07:31 +0100
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
        kernel-team@android.com, Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH v7 08/22] cpuset: Don't use the cpu_possible_mask as a
 last resort for cgroup v1
Message-ID: <20210526160730.GC19691@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-9-will@kernel.org>
 <YK5i/GQ/30hSsYBU@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK5i/GQ/30hSsYBU@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 05:02:20PM +0200, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 04:14:18PM +0100, Will Deacon wrote:
> >  void cpuset_cpus_allowed_fallback(struct task_struct *tsk)
> >  {
> > +	const struct cpumask *cs_mask;
> > +	const struct cpumask *possible_mask = task_cpu_possible_mask(tsk);
> > +
> >  	rcu_read_lock();
> > +	cs_mask = task_cs(tsk)->cpus_allowed;
> > +
> > +	if (!is_in_v2_mode() || !cpumask_subset(cs_mask, possible_mask))
> > +		goto unlock; /* select_fallback_rq will try harder */
> > +
> > +	do_set_cpus_allowed(tsk, cs_mask);
> > +unlock:
> 
> 	if (is_in_v2_mode() && cpumask_subset(cs_mask, possible_mask))
> 		do_set_cpus_allowed(tsk, cs_mask);
> 
> perhaps?

Absolutely.

Will

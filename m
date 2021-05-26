Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2679B391D7C
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 19:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233913AbhEZRDu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 13:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:46116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233694AbhEZRDp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 13:03:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A78C8613D7;
        Wed, 26 May 2021 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622048533;
        bh=GCTzDVbHhIB2dVSmWs+GdL224HTZFecYBcEfT7zK7IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYqblIvys8lw3GCSXlPEL2PYKMcev0OROB2qn9Wj8kynBUZ/fF72oEBS6FVqh25Rd
         Wl+R+5/zO+9k4vaGv+4dpmi1KjfrP4dCT6SxIuSyOWFCw4P8sU7dWYnkYLJAYLdpig
         j4MGc8JX7tDHtfZTdzmmN0qX5U7OWTJlPZEsdpoVh3T4IEF8Wacl6HU9rArjCz3v2h
         PGeaa2xslmuL27ULOUbz75vQBRWNEdXe2jqTtuSfyUE/8dgL5/Fl+mGHKTHhs1pu+H
         E6WrI4UY+Swaf48ho0/zMxr9nmXT3V7VqOFGyejLps4MF7NkkwhrhtNx50W+X5fYw1
         2B2nh7481ezzA==
Date:   Wed, 26 May 2021 18:02:06 +0100
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
        kernel-team@android.com
Subject: Re: [PATCH v7 13/22] sched: Allow task CPU affinity to be restricted
 on asymmetric systems
Message-ID: <20210526170206.GB19758@willie-the-truck>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-14-will@kernel.org>
 <YK53kDtczHIYumDC@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK53kDtczHIYumDC@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 26, 2021 at 06:30:08PM +0200, Peter Zijlstra wrote:
> On Tue, May 25, 2021 at 04:14:23PM +0100, Will Deacon wrote:
> > @@ -2426,20 +2421,166 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
> >  
> >  	__do_set_cpus_allowed(p, new_mask, flags);
> >  
> > -	return affine_move_task(rq, p, &rf, dest_cpu, flags);
> > +	if (flags & SCA_USER)
> > +		release_user_cpus_ptr(p);
> > +
> > +	return affine_move_task(rq, p, rf, dest_cpu, flags);
> >  
> >  out:
> > -	task_rq_unlock(rq, p, &rf);
> > +	task_rq_unlock(rq, p, rf);
> >  
> >  	return ret;
> >  }
> 
> So sys_sched_setaffinity() releases the user_cpus_ptr thingy ?! How does
> that work?

Right, I think if the task explicitly changes its affinity then it makes
sense to forget about what it had before. It then behaves very similar to
CPU hotplug, which is the analogy I've been trying to follow: if you call
sched_setaffinity() with a mask containing offline CPUs then those CPUs
are not added back to the affinity mask when they are onlined.

> I thought the intended semantics were somethings like:
> 
> 	A - 0xff			B
> 
> 	restrict(0xf) // user: 0xff eff: 0xf
> 
> 					sched_setaffinity(A, 0x3c) // user: 0x3c eff: 0xc
> 
> 	relax() // user: NULL, eff: 0x3c

If you go down this route you can get into _really_ weird situations where
e.g. sys_sched_setaffinity() returns -EINVAL because the requested mask
contains only 64-bit-only cores, yet we've updated the user mask. It also
opens up some horrendous races between sched_setaffinity() and execve(),
since the former can transiently set an invalid mask per the cpuset
hierarchy.

Will

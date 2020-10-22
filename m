Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE08F295CF1
	for <lists+linux-arch@lfdr.de>; Thu, 22 Oct 2020 12:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896727AbgJVKtx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Oct 2020 06:49:53 -0400
Received: from foss.arm.com ([217.140.110.172]:54028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896713AbgJVKtn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Oct 2020 06:49:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 754DAD6E;
        Thu, 22 Oct 2020 03:48:47 -0700 (PDT)
Received: from e107158-lin (unknown [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20E6F3F66B;
        Thu, 22 Oct 2020 03:48:46 -0700 (PDT)
Date:   Thu, 22 Oct 2020 11:48:43 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     linux-arch@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201022104843.2lg33svtxloirvdb@e107158-lin>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021121559.GB3976@gaia>
 <20201021133316.GF8004@e123083-lin>
 <20201021143153.7ef7n7gdd42l4rbc@e107158-lin>
 <20201022101624.GI8004@e123083-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201022101624.GI8004@e123083-lin>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/22/20 12:16, Morten Rasmussen wrote:
> On Wed, Oct 21, 2020 at 03:31:53PM +0100, Qais Yousef wrote:
> > On 10/21/20 15:33, Morten Rasmussen wrote:
> > > On Wed, Oct 21, 2020 at 01:15:59PM +0100, Catalin Marinas wrote:
> > > > one, though not as easy as automatic task placement by the scheduler (my
> > > > first preference, followed by the id_* regs and the aarch32 mask, though
> > > > not a strong preference for any).
> > > 
> > > Automatic task placement by the scheduler would mean giving up the
> > > requirement that the user-space affinity mask must always be honoured.
> > > Is that on the table?
> > > 
> > > Killing aarch32 tasks with an empty intersection between the user-space
> > > mask and aarch32_mask is not really "automatic" and would require the
> > > aarch32 capability to be exposed anyway.
> > 
> > I just noticed this nasty corner case too.
> > 
> > 
> > Documentation/admin-guide/cgroup-v1/cpusets.rst: Section 1.9
> > 
> > "If such a task had been bound to some subset of its cpuset using the
> > sched_setaffinity() call, the task will be allowed to run on any CPU allowed in
> > its new cpuset, negating the effect of the prior sched_setaffinity() call."
> > 
> > So user space must put the tasks into a valid cpuset to fix the problem. Or
> > make the scheduler behave like the affinity is associated with a cpuset.
> > 
> > Can user space put the task into the correct cpuset without a race? Clone3
> > syscall learnt to specify a cgroup to attach to when forking. Should we do the
> > same for execve()?
> 
> Putting a task in a cpuset overrides any affinity mask applied by a
> previous cpuset or sched_setaffinity() call. I wouldn't call it a corner
> case though. Android user-space is exploiting it all the time on some
> devices through the foreground, background, and top-app cgroups.

Yep. What I was referring to is that if we go the kernel fixing affinity
automatically route, that cpuset behavior will be problematic. In this case
fixing the affinity at the task level will not be enough because cpusets will
override it. So catering for that is another complication to take into account.

> If a tasks fork() the child task will belong to the same cgroup
> automatically. If you execve() you retain the previous affinity mask and
> cgroup. So putting parent task about to execve() into aarch32 into a
> cpuset with only aarch32 CPUs should be enough to never have the task or
> any of its child tasks SIGKILLED.
> 
> A few simple experiments with fork() and execve() seems to confirm that.

+1

This made me wonder what happens when SCHED_RESET_ON_FORK is set. It only
resets policty and priority. So we're good.

> I don't see any changes needed in the kernel. Changing cgroup through
> clone could of course fail if user-space specifies an unsuitable cgroup.
> Fixing that would be part of fixing the cpuset setup in user-space which
> is required anyway.

+1

Thanks

--
Qais Yousef

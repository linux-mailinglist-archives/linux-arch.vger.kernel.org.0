Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28732DB408
	for <lists+linux-arch@lfdr.de>; Tue, 15 Dec 2020 19:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgLOSvH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Dec 2020 13:51:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730986AbgLOSvA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Dec 2020 13:51:00 -0500
Date:   Tue, 15 Dec 2020 18:50:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608058219;
        bh=MKgw43Ypee3WU7GugZbs2s0TT/yPlkdAlchXugo1lfI=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEZWCgyLGFu/NwVira6zIssKDYsFZ1g2zNgWvAkbCIxsqmqusMrLfEevomUWXemo5
         cpFvufPWYRZeY5x3qSVG3YewWvcCu8VgeE6ZhUr+smCfVHEtX0/ieOPrWHYxpIBnDu
         z3dPjzz5vFteDJNjRKbUL7cOthCMDOxGD817BYowyDuUmT59sJ5p+J/Xw2k20DsCS0
         gbDurW2cgIaoK/3uKs5x8WoPDPByFaJFc3nEFmpPc/eUHQ1AEeBKg0lc9sRGlYsf/X
         47Al/bb8QhvUP8NtJwBTbOalBrWp6zohe/pgrcsqgjc1p1tnjo92OMyvOp6LOTFDtl
         J9GBZDVgXqOxw==
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
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v5 00/15] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201215185012.GA15566@willie-the-truck>
References: <20201208132835.6151-1-will@kernel.org>
 <20201215173645.GJ3040@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215173645.GJ3040@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Peter,

Cheers for taking a look.

On Tue, Dec 15, 2020 at 06:36:45PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 08, 2020 at 01:28:20PM +0000, Will Deacon wrote:
> > The aim of this series is to allow 32-bit ARM applications to run on
> > arm64 SoCs where not all of the CPUs support the 32-bit instruction set.
> > Unfortunately, such SoCs are real and will continue to be productised
> > over the next few years at least. I can assure you that I'm not just
> > doing this for fun.
> > 
> > Changes in v5 include:
> > 
> >   * Teach cpuset_cpus_allowed() about task_cpu_possible_mask() so that
> >     we can avoid returning incompatible CPUs for a given task. This
> >     means that sched_setaffinity() can be used with larger masks (like
> >     the online mask) from userspace and also allows us to take into
> >     account the cpuset hierarchy when forcefully overriding the affinity
> >     for a task on execve().
> > 
> >   * Honour task_cpu_possible_mask() when attaching a task to a cpuset,
> >     so that the resulting affinity mask does not contain any incompatible
> >     CPUs (since it would be rejected by set_cpus_allowed_ptr() otherwise).
> > 
> >   * Moved overriding of the affinity mask into the scheduler core rather
> >     than munge affinity masks directly in the architecture backend.
> 
> Hurmph... so if I can still read, this thing will auto truncate the
> affinity mask to something that only contains compatible CPUs, right?
> 
> Assuming our system has 8 CPUs (0xFF), half of which are 32bit capable
> (0x0F), then, when our native task (with affinity 0x3c) does a
> fork()+execve() of a 32bit thingy the resulting task has 0x0c.
> 
> If that in turn does fork()+execve() of a native task, it will retain
> the trucated affinity mask (0x0c), instead of returning to the wider
> mask (0x3c).
> 
> IOW, any (accidental or otherwise) trip through a 32bit helper, will
> destroy user state (the affinity mask: 0x3c).

Yes, that's correct, and I agree that it's a rough edge. If you're happy
with the idea of adding an extra mask to make this work, then I can start
hacking that up (although I doubt I'll get something out before the new
year at this point).

> Should we perhaps split task_struct::cpus_mask, one to keep an original
> copy of the user state, and one to be an effective cpumask for the task?
> That way, the moment a task constricts or widens it's
> task_cpu_possible_mask() we can re-compute the effective mask without
> loss of information.

Hmm, we might already have most of the pieces in place for this (modulo
the extra field), since cpuset_cpus_allowed() provides the limiting mask
now so this might be relatively straightforward.

Famous last words...

Will

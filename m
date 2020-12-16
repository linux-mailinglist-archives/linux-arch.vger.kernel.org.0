Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646312DC1F9
	for <lists+linux-arch@lfdr.de>; Wed, 16 Dec 2020 15:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgLPOPj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 16 Dec 2020 09:15:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgLPOPi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 16 Dec 2020 09:15:38 -0500
Date:   Wed, 16 Dec 2020 14:14:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608128097;
        bh=JRmLTb9vVZmeLkgH4oxPhqDkLovLa+K8GzZyXFI9EE0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=WjUgPkf8XDXt4DYW+AjZ4fewGswVEaSmREuXLaDK8Sk72wiegW3C9XREP/6e1HJVT
         oc99CN2JiS2wcdGl1bJDf/Wyl9GVLZINhG77zdYoz76pmblOmm6uk35loVLU5b55Z7
         ewmEefl+zvKUCBxlnD0uAfrkwG+gP1R36LaK1MPg7zTZcP6fakpxs/aJEM49+GA2hH
         OG7yNYfsmiXUzH5CFo/na4JA0Fdr/HS/1n11/nGGL6XUMWfa9lYt5neDWQ3MBdCGC0
         875f4M1Yw4rf01dhatRfHoMf28EcK6u1E2yhM5ROfyi8DO6BcPwVopcUpzDvrw72Xw
         nPFfJDHtdKnxg==
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>, surenb@google.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v5 00/15] An alternative series for asymmetric AArch32
 systems
Message-ID: <20201216141450.GA16421@willie-the-truck>
References: <20201208132835.6151-1-will@kernel.org>
 <20201216111646.omrxyhbobejzqprh@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201216111646.omrxyhbobejzqprh@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Qais,

On Wed, Dec 16, 2020 at 11:16:46AM +0000, Qais Yousef wrote:
> On 12/08/20 13:28, Will Deacon wrote:
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
> > 
> >   * Extended comments and documentation.
> > 
> >   * Some renaming and cosmetic changes.
> > 
> > I'm pretty happy with this now, although it still needs review and will
> > require rebasing to play nicely with the SCA changes in -next.
> 
> I still have concerns about the cpuset v1 handling. Specifically:
> 
> 	1. Attaching a 32bit task to 64bit only cpuset is allowed.
> 
> 	   I think the right behavior here is to prevent that as the
> 	   intersection will appear as offline cpus for the 32bit tasks. So it
> 	   shouldn't be allowed to move there.

Suren or Quantin can correct me if I'm wrong I'm here, but I think Android
relies on this working so it's not an option for us to prevent the attach.
I also don't think it really achieves much, since as you point out, the same
problem exists in other cases such as execve() of a 32-bit binary, or
hotplugging off all 32-bit CPUs within a mixed cpuset. Allowing the attach
and immediately reparenting would probably be better, but see below.

> 	2. Modifying cpuset.cpus could result with empty set for 32bit tasks.
> 
> 	   It is a variation of the above, it's just the cpuset transforms into
> 	   64bit only after we attach.
> 
> 	   I think the right behavior here is to move the 32bit tasks to the
> 	   nearest ancestor like we do when all cpuset.cpus are hotplugged out.
> 
> 	   We could too return an error if the new set will result an empty set
> 	   for the 32bit tasks. In a similar manner to how it fails if you
> 	   write a cpu that is offline.
> 
> 	3. If a 64bit task belongs to 64bit-only-cpuset execs a 32bit binary,
> 	   the 32 tasks will inherit the cgroup setting.
> 
> 	   Like above, we should move this to the nearest ancestor.

I considered this when I was writing the patches, but the reality is that
by allowing 32-bit tasks to attach to a 64-bit only cpuset (which is required
by Android), we have no choice but to expose a new ABI to userspace. This is
all gated behind a command-line option, so I think that's fine, but then why
not just have the same behaviour as cgroup v2? I don't see the point in
creating two new ABIs (for cgroup v1 and v2 respectively) if we don't need
to. If it was _identical_ to the hotplug case, then we would surely just
follow the existing behaviour, but it's really quite different in this
situation because the cpuset is not empty.

One thing we should definitely do though is add this to the documentation
for the command-line option.

> To simplify the problem for v1, we could say that asym ISA tasks can only live
> in the root cpuset for v1. This will simplify the solution too since we will
> only need to ensure that these tasks are moved to the root group on exec and
> block any future move to anything else. Of course this dictates that such
> systems must use cpuset v2 if they care. Not a terrible restriction IMO.

Sadly, I think Android is still on cgroup v1 for cpuset, but Suren will know
better the status of cgroup v2 for cpusets. If it's just around the corner,
then maybe we could simplify things here. Suren?

Will

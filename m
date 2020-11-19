Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CEC2B90A0
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 12:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgKSLGM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 06:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:33014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726648AbgKSLGM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 06:06:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B45DC246EE;
        Thu, 19 Nov 2020 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605783970;
        bh=1olbbRVpFSDdgOVTAb7nOB/GsIqWepxCIAnl/2QcUOY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bOoK78rMWppAJaCZjoxWoQM+hZk44QoEbwpJXH2UoGsKdR3L8C7Bnoy9diDciCbr
         lskHGFiMdBgG9dEnf/rpk5/F3ZqVt7HK3sakNJOTCewJ5RdjJBj7SCxUIY8OpU2Uui
         jy8sydY+NQnzp4aIgIs2Xl1atp6h1m/x7/3+iZnY=
Date:   Thu, 19 Nov 2020 11:06:04 +0000
From:   Will Deacon <will@kernel.org>
To:     Quentin Perret <qperret@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com
Subject: Re: [PATCH v3 08/14] arm64: exec: Adjust affinity for compat tasks
 with mismatched 32-bit EL0
Message-ID: <20201119110603.GB3946@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-9-will@kernel.org>
 <20201119092407.GB2416649@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119092407.GB2416649@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 09:24:07AM +0000, Quentin Perret wrote:
> On Friday 13 Nov 2020 at 09:37:13 (+0000), Will Deacon wrote:
> > When exec'ing a 32-bit task on a system with mismatched support for
> > 32-bit EL0, try to ensure that it starts life on a CPU that can actually
> > run it.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  arch/arm64/kernel/process.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> > index 1540ab0fbf23..17b94007fed4 100644
> > --- a/arch/arm64/kernel/process.c
> > +++ b/arch/arm64/kernel/process.c
> > @@ -625,6 +625,16 @@ unsigned long arch_align_stack(unsigned long sp)
> >  	return sp & ~0xf;
> >  }
> >  
> > +static void adjust_compat_task_affinity(struct task_struct *p)
> > +{
> > +	const struct cpumask *mask = system_32bit_el0_cpumask();
> > +
> > +	if (restrict_cpus_allowed_ptr(p, mask))
> > +		set_cpus_allowed_ptr(p, mask);
> 
> My understanding of this call to set_cpus_allowed_ptr() is that you're
> mimicking the hotplug vs affinity case behaviour in some ways. That is,
> if a task is pinned to a CPU and userspace hotplugs that CPU, then the
> kernel will reset the affinity of the task to the remaining online CPUs.

Correct. It looks to the 32-bit application like all the 64-bit-only CPUs
were hotplugged off at the point of the execve().

> I guess that is a sensible fallback path when userspace gives
> contradictory commands to the kernel, but that most certainly deserves a
> comment :)

Good point, I'll add this:

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index dba94af1b840..687d6acf2f81 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -619,6 +619,16 @@ static void adjust_compat_task_affinity(struct task_struct *p)
 {
 	const struct cpumask *mask = system_32bit_el0_cpumask();
 
+	/*
+	 * Restrict the CPU affinity mask for a 32-bit task so that it contains
+	 * only the 32-bit-capable subset of its original CPU mask. If this is
+	 * empty, then forcefully override it with the set of all
+	 * 32-bit-capable CPUs that we know about.
+	 *
+	 * From the perspective of the task, this looks similar to what would
+	 * happen if the 64-bit-only CPUs were hot-unplugged at the point of
+	 * execve().
+	 */
 	if (restrict_cpus_allowed_ptr(p, mask))
 		set_cpus_allowed_ptr(p, mask);
 }

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F27D2B9378
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 14:14:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgKSNN2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 08:13:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:35688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727256AbgKSNN2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 08:13:28 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8509C2222F;
        Thu, 19 Nov 2020 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605791606;
        bh=pF1+bQPIV/x/ycXsIteg60G2ja8P58hY9cj6PP793Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SR1ksZcguj8zfaJ0h9Ob2NaE+LgsZfes4POXJ6c3ZmjBANe0TFn03ThdGgG2GW5pa
         Hc2o78ghFbK4OmJ+QQ+qDwn46/N22+gxzQn6Y2HaUCqccqn+atfu48Rcm40gnCjtF6
         I1rQ9XAqYRcy41WqAka3E2iDm/roxr64i+vEGLwc=
Date:   Thu, 19 Nov 2020 13:13:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
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
Subject: Re: [PATCH v3 07/14] sched: Introduce restrict_cpus_allowed_ptr() to
 limit task CPU affinity
Message-ID: <20201119131319.GE4331@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-8-will@kernel.org>
 <jhj8saxwm1l.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jhj8saxwm1l.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 12:47:34PM +0000, Valentin Schneider wrote:
> 
> On 13/11/20 09:37, Will Deacon wrote:
> > Asymmetric systems may not offer the same level of userspace ISA support
> > across all CPUs, meaning that some applications cannot be executed by
> > some CPUs. As a concrete example, upcoming arm64 big.LITTLE designs do
> > not feature support for 32-bit applications on both clusters.
> >
> > Although userspace can carefully manage the affinity masks for such
> > tasks, one place where it is particularly problematic is execve()
> > because the CPU on which the execve() is occurring may be incompatible
> > with the new application image. In such a situation, it is desirable to
> > restrict the affinity mask of the task and ensure that the new image is
> > entered on a compatible CPU.
> 
> > From userspace's point of view, this looks the same as if the
> > incompatible CPUs have been hotplugged off in its affinity mask.
> 
> {pedantic reading warning}
> 
> Hotplugged CPUs *can* be set in a task's affinity mask, though interact
> weirdly with cpusets [1]. Having it be the same as hotplug would mean
> keeping incompatible CPUs allowed in the affinity mask, but preventing them
> from being picked via e.g. is_cpu_allowed().

Sure, but I was talking about what userspace sees, and I don't think it ever
sees CPUs that have been hotplugged off, right? That is, sched_getaffinity()
masks its result with the active_mask.

> I was actually hoping this could be a feasible approach, i.e. have an
> extra CPU active mask filter for any task:
> 
>   cpu_active_mask & arch_cpu_allowed_mask(p)
> 
> rather than fiddle with task affinity. Sadly this would also require fixing
> up pretty much any place that uses cpu_active_mask(), and probably places
> that use p->cpus_ptr as well. RT / DL balancing comes to mind, because that
> uses either a task's affinity or a CPU's root domain (which reflects the
> cpu_active_mask) to figure out where to push a task.

Yeah, I tried this at one point and you end up playing whack-a-mole trying
to figure out why a task got killed. p->cpus_ptr is used all over the place,
and I think if we took this approach then we couldn't realistically remove
the sanity check on the ret-to-user path.

> So while I'm wary of hacking up affinity, I fear it might be the lesser
> evil :(

It's the best thing I've been able to come up with.

Will

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD0F22B9859
	for <lists+linux-arch@lfdr.de>; Thu, 19 Nov 2020 17:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgKSQoV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Nov 2020 11:44:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727853AbgKSQoV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 19 Nov 2020 11:44:21 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 084F222227;
        Thu, 19 Nov 2020 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605804260;
        bh=X0dkfAQ/RZZ0vc2DWgesSKsb7UCpnk9G0pl0RaG4zEU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4TottIk5krhLkqXtTph8vd7A6u5ljjlWbxWAjXe7Z6sXYTNYXXzCMAmXoSwHW9xt
         lp2lRVO+8F83dkUQ6edvDpjIdmhyWiyoHgylpmZr4ZHEDl5k1b+7IYCN9lKCYwG1NV
         hzMVdWYRKIw5zsRHRpKcB7LT73Rf0cTKUh84Cf4s=
Date:   Thu, 19 Nov 2020 16:44:13 +0000
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
Subject: Re: [PATCH v3 11/14] sched: Reject CPU affinity changes based on
 arch_cpu_allowed_mask()
Message-ID: <20201119164412.GE4582@willie-the-truck>
References: <20201113093720.21106-1-will@kernel.org>
 <20201113093720.21106-12-will@kernel.org>
 <20201119094744.GE2416649@google.com>
 <20201119110723.GE3946@willie-the-truck>
 <20201119143012.GA2458028@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119143012.GA2458028@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 19, 2020 at 02:30:12PM +0000, Quentin Perret wrote:
> On Thursday 19 Nov 2020 at 11:07:24 (+0000), Will Deacon wrote:
> > Yeah, the cpuset code ignores the return value of set_cpus_allowed_ptr() in
> > update_tasks_cpumask() so the failure won't be propagated, but then again I
> > think that might be the right thing to do. Nothing prevents 32-bit and
> > 64-bit tasks from co-existing in the same cpuseti afaict, so forcing the
> > 64-bit tasks onto the 32-bit-capable cores feels much worse than the
> > approach taken here imo.
> 
> Ack. And thinking about it more, failing the cgroup operation wouldn't
> guarantee that the task's affinity and the cpuset are aligned anyway. We
> could still exec into a 32 bit task from within a 64 bit-only cpuset.
> 
> > The interesting case is what happens if the cpuset for a 32-bit task is
> > changed to contain only the 64-bit-only cores. I think that's a userspace
> > bug
> 
> Maybe, but I think Android will do exactly that in some cases :/
> 
> > but the fallback rq selection should avert disaster.
> 
> I thought _this_ patch was 'fixing' this case by making the cpuset
> operation pretty much a nop on the task affinity? The fallback rq stuff
> is all about hotplug no?

Yeah, sorry, I wasn't clear. This patch postpones disaster until hotplug
off time, when cpuset_cpus_allowed_fallback() will fail and
select_fallback_rq() will have to step in.

Will

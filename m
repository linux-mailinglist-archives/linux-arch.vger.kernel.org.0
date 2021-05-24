Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9FD38F51A
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 23:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbhEXVr5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 17:47:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232693AbhEXVr5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 17:47:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80D7B6140F;
        Mon, 24 May 2021 21:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621892788;
        bh=pIqcwhnobnjNtorg38viD7Ev04FdWPKbGKaiT70sphw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqlUf1coLr/eocDF0EyjRwzf6YJvk2jL0KLJC3/80LIoV1iV/SHgWo0LJElWlXM6p
         VkYfo6o3495XQ0gUwyw4FeIYHKnKH06ZwUJvJH7wh56Ou/GmgW45m6EXuysQLL2jaR
         5SLgBzFlcTuMfUSW7GFsCpCsr9GJJM5VBUQgPhhsRwFZQRBcB6Zg9Xce88IXlFtLtx
         c5ivaG7kcgdQA9KAkhnTxFDg01DNFKOpPwuQXMQ1xT3+yejxO0JTIfyyE6fYhQFom/
         rLs1KaAhZnJroH/ZPgGFxVwCDdZrAX7MU0Hfp9TEY6MWdJ/XQLVQ6Ef8vwN6OUEg+e
         pw/HP7TqPYgfw==
Date:   Mon, 24 May 2021 22:46:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Quentin Perret <qperret@google.com>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, kernel-team@android.com
Subject: Re: [PATCH v6 21/21] Documentation: arm64: describe asymmetric
 32-bit support
Message-ID: <20210524214622.GI15545@willie-the-truck>
References: <20210518094725.7701-1-will@kernel.org>
 <20210518094725.7701-22-will@kernel.org>
 <20210521173721.untjfglvxja6v6ot@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210521173721.untjfglvxja6v6ot@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 21, 2021 at 06:37:21PM +0100, Qais Yousef wrote:
> On 05/18/21 10:47, Will Deacon wrote:
> > Document support for running 32-bit tasks on asymmetric 32-bit systems
> > and its impact on the user ABI when enabled.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  .../admin-guide/kernel-parameters.txt         |   3 +
> >  Documentation/arm64/asymmetric-32bit.rst      | 149 ++++++++++++++++++
> >  Documentation/arm64/index.rst                 |   1 +
> >  3 files changed, 153 insertions(+)
> >  create mode 100644 Documentation/arm64/asymmetric-32bit.rst
> > 
> 
> [...]
> 
> > +Cpusets
> > +-------
> > +
> > +The affinity of a 32-bit task may include CPUs that are not explicitly
> > +allowed by the cpuset to which it is attached. This can occur as a
> > +result of the following two situations:
> > +
> > +  - A 64-bit task attached to a cpuset which allows only 64-bit CPUs
> > +    executes a 32-bit program.
> > +
> > +  - All of the 32-bit-capable CPUs allowed by a cpuset containing a
> > +    32-bit task are offlined.
> > +
> > +In both of these cases, the new affinity is calculated according to step
> > +(2) of the process described in `execve(2)`_ and the cpuset hierarchy is
> > +unchanged irrespective of the cgroup version.
> 
> nit: Should we call out that we're breaking cpuset-v1 behavior? Don't feel
> strongly about it.

I think the text is pretty clear that the new behaviour documented here
applies to cpuset-v1 and I wouldn't say we're breaking anything as we're not
changing any of the existing behaviours.

Will

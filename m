Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3A2CA925
	for <lists+linux-arch@lfdr.de>; Tue,  1 Dec 2020 18:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390685AbgLAQ5c (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Dec 2020 11:57:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:41650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389973AbgLAQ5b (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Dec 2020 11:57:31 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D123020758;
        Tue,  1 Dec 2020 16:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606841811;
        bh=47Bn+tKERV4chnDwa7E8zZqamljNfOW477mi08QNoDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Chlj77m4jFNnf/tW2F7OTYLtTFZouzMMnoyCFjFaGErrmL4m9OkRK4MYs69Glxkiu
         aGRln1OC9pFrsapyD0w+1455b9BLGIvtBdmmMcNn1hZ83yU5VWeXxyfOrFlkeJidJe
         YnuIVmKD6lFUMApvHZebKiZJzl8tfWO2sSCWlW+c=
Date:   Tue, 1 Dec 2020 16:56:44 +0000
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
        kernel-team@android.com
Subject: Re: [PATCH v4 06/14] arm64: Hook up cmdline parameter to allow
 mismatched 32-bit EL0
Message-ID: <20201201165643.GD27783@willie-the-truck>
References: <20201124155039.13804-1-will@kernel.org>
 <20201124155039.13804-7-will@kernel.org>
 <20201127131759.5o5qiv2uwtb6qadl@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201127131759.5o5qiv2uwtb6qadl@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 27, 2020 at 01:17:59PM +0000, Qais Yousef wrote:
> On 11/24/20 15:50, Will Deacon wrote:
> > Allow systems with mismatched 32-bit support at EL0 to run 32-bit
> > applications based on a new kernel parameter.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 7 +++++++
> >  arch/arm64/kernel/cpufeature.c                  | 7 +++++++
> >  2 files changed, 14 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 526d65d8573a..f20188c44d83 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -289,6 +289,13 @@
> >  			do not want to use tracing_snapshot_alloc() as it needs
> >  			to be done where GFP_KERNEL allocations are allowed.
> >  
> > +	allow_mismatched_32bit_el0 [ARM64]
> > +			Allow execve() of 32-bit applications and setting of the
> > +			PER_LINUX32 personality on systems where only a strict
> > +			subset of the CPUs support 32-bit EL0. When this
> > +			parameter is present, the set of CPUs supporting 32-bit
> > +			EL0 is indicated by /sys/devices/system/cpu/aarch32_el0.
> 
> Shouldn't we document that a randomly selected 32-bit CPU will be prevented
> from being hotplugged out all the time to act as the last man standing for any
> currently running 32-bit application.
> 
> That was a mouthful! I'm sure you can phrase it better :-)

Sure, I'll have a go at adding something. Thanks.

> If we make this the last patch as it was before adding affinity handling, we
> can drop patch 4 more easily I think?

I'd still prefer to keep patch 4, but I can certainly try to move this one
later in the series.

Will

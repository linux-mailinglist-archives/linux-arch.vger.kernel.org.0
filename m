Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1310391B7A
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 17:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbhEZPS3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 11:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbhEZPS2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 26 May 2021 11:18:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B4CC061574;
        Wed, 26 May 2021 08:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=B480aaO2rxlrnIc+fI2c45cdJeBughiR9HhYUCJoqp4=; b=dkkSVZ57J19yhpw/Kd8ax12s27
        wfbw3QtiaX0CKX2eY2/JpK1l/nzQqetSt7yExUXtufZ594v9dloXiYAg2tK60bwDotMfR4DSgeq1G
        CPR5iwtxLi9Rmcs4eoJc4uPB8YvWznp4BonvXm8PdSag2DPdpw7kxKhdz0K/jw5tsHhHpoZi9bUsP
        hbLhbE4RdBuPErMMvmOM4WyRSt/pItSzAKPWw/6oeO8jJv9gCGhf2WFDp5EdFoJTgAkNN/KI/uirv
        mw3M47EWfn4E1JXupcfmaip0BglBgabrba6ufnudJAGGIsdCvGGSDHhMrAEoaxOKO/IOJyVsTyzsd
        EofQrECQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1llvGC-004dwG-QY; Wed, 26 May 2021 15:16:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C21EB30022A;
        Wed, 26 May 2021 17:15:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4CEF200D3A72; Wed, 26 May 2021 17:15:51 +0200 (CEST)
Date:   Wed, 26 May 2021 17:15:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Will Deacon <will@kernel.org>
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
Subject: Re: [PATCH v7 10/22] sched: Reject CPU affinity changes based on
 task_cpu_possible_mask()
Message-ID: <YK5mJxsmxosX1ciH@hirez.programming.kicks-ass.net>
References: <20210525151432.16875-1-will@kernel.org>
 <20210525151432.16875-11-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525151432.16875-11-will@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 25, 2021 at 04:14:20PM +0100, Will Deacon wrote:
> Reject explicit requests to change the affinity mask of a task via
> set_cpus_allowed_ptr() if the requested mask is not a subset of the
> mask returned by task_cpu_possible_mask(). This ensures that the
> 'cpus_mask' for a given task cannot contain CPUs which are incapable of
> executing it, except in cases where the affinity is forced.
> 
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  kernel/sched/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 00ed51528c70..8ca7854747f1 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2346,6 +2346,7 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  				  u32 flags)
>  {
>  	const struct cpumask *cpu_valid_mask = cpu_active_mask;
> +	const struct cpumask *cpu_allowed_mask = task_cpu_possible_mask(p);
>  	unsigned int dest_cpu;
>  	struct rq_flags rf;
>  	struct rq *rq;
> @@ -2366,6 +2367,9 @@ static int __set_cpus_allowed_ptr(struct task_struct *p,
>  		 * set_cpus_allowed_common() and actually reset p->cpus_ptr.
>  		 */
>  		cpu_valid_mask = cpu_online_mask;
> +	} else if (!cpumask_subset(new_mask, cpu_allowed_mask)) {
> +		ret = -EINVAL;
> +		goto out;
>  	}

So what about the case where the 32bit task is in-kernel and in
migrate-disable ? surely we ought to still validate the new mask against
task_cpu_possible_mask.

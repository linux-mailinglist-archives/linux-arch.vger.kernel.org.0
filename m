Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 268AB288381
	for <lists+linux-arch@lfdr.de>; Fri,  9 Oct 2020 09:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbgJIH3w (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Oct 2020 03:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbgJIH3w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Oct 2020 03:29:52 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FFBC0613D2
        for <linux-arch@vger.kernel.org>; Fri,  9 Oct 2020 00:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IQClYgm3wz3qBmeMn9CVUnYoWhcZUrjXwyBCjKGahm0=; b=GPd+w2/RxLccLoVbyapGgMPsUf
        8+tBJwiMc1c7IY7umOIb8AZL6K8WE/kIJOyM8uYzStXJe//krJPxbHMMZHjtVWoftwFpZw9ZJhmvj
        i4hmkSUAtUsLNhTXwViBm7dXqK7j6jrQPmZaaomg4WqmUoPzG3cDTYBM9H0UXGuizQFH2CXtKa8RJ
        BsHX4/NoldWGz4nPkEzecWNRPj66zjtLyXPNuddDD9cbv9WNElFO5+a5q3o5FXiwcHuaiHqKZkGwm
        l8fI1lRzPJqixoVmkZ8+OBnVHNM9Mm+QcSa6t9S1ywrbOgh+/wu0kFusVuODGtS09JyqchZdytWMz
        0SeInrDw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kQmqY-0003ya-BT; Fri, 09 Oct 2020 07:29:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 06F25301A27;
        Fri,  9 Oct 2020 09:29:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C34D52019D2CA; Fri,  9 Oct 2020 09:29:43 +0200 (CEST)
Date:   Fri, 9 Oct 2020 09:29:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] arm64: Handle AArch32 tasks running on non
 AArch32 cpu
Message-ID: <20201009072943.GD2628@hirez.programming.kicks-ass.net>
References: <20201008181641.32767-1-qais.yousef@arm.com>
 <20201008181641.32767-4-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201008181641.32767-4-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 08, 2020 at 07:16:41PM +0100, Qais Yousef wrote:
> diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
> index cf94cc248fbe..7e97f1589f33 100644
> --- a/arch/arm64/kernel/signal.c
> +++ b/arch/arm64/kernel/signal.c
> @@ -908,13 +908,28 @@ static void do_signal(struct pt_regs *regs)
>  	restore_saved_sigmask();
>  }
>  
> +static void set_32bit_cpus_allowed(void)
>  {
> +	cpumask_var_t cpus_allowed;
> +	int ret = 0;
> +
> +	if (cpumask_subset(current->cpus_ptr, &aarch32_el0_mask))
> +		return;
> +
>  	/*
> +	 * On asym aarch32 systems, if the task has invalid cpus in its mask,
> +	 * we try to fix it by removing the invalid ones.
>  	 */
> +	if (!alloc_cpumask_var(&cpus_allowed, GFP_ATOMIC)) {
> +		ret = -ENOMEM;
> +	} else {
> +		cpumask_and(cpus_allowed, current->cpus_ptr, &aarch32_el0_mask);
> +		ret = set_cpus_allowed_ptr(current, cpus_allowed);
> +		free_cpumask_var(cpus_allowed);
> +	}
> +
> +	if (ret) {
> +		pr_warn_once("Failed to fixup affinity of running 32-bit task\n");
>  		force_sig(SIGKILL);
>  	}
>  }

Yeah, no. Not going to happen.

Fundamentally, you're not supposed to change the userspace provided
affinity mask. If we want to do something like this, we'll have to teach
the scheduler about this second mask such that it can compute an
effective mask as the intersection between the 'feature' and user mask.

Also, practically, using ->cpus_ptr here to construct the mask will be
really dodgy vs the proposed migrate_disable() patches.


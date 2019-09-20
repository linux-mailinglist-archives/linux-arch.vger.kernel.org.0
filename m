Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABF3FB8FAC
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2019 14:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408844AbfITMVV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Sep 2019 08:21:21 -0400
Received: from foss.arm.com ([217.140.110.172]:44126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406276AbfITMVV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Sep 2019 08:21:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C784328;
        Fri, 20 Sep 2019 05:21:20 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599B73F67D;
        Fri, 20 Sep 2019 05:21:19 -0700 (PDT)
Date:   Fri, 20 Sep 2019 13:21:17 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC patch 04/15] arm64/entry: Use generic syscall entry function
Message-ID: <20190920122116.GA21231@arrakis.emea.arm.com>
References: <20190919150314.054351477@linutronix.de>
 <20190919150808.830764150@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150808.830764150@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 19, 2019 at 05:03:18PM +0200, Thomas Gleixner wrote:
>  #ifdef CONFIG_ARM64_ERRATUM_1463225
> @@ -97,19 +97,16 @@ static void el0_svc_common(struct pt_reg
>  
>  	regs->orig_x0 = regs->regs[0];
>  	regs->syscallno = scno;
> +	/* Set default error number */
> +	regs->regs[0] = -ENOSYS;

I think this corrupts the first argument of all valid syscalls.
SC_ARM64_REGS_TO_ARGS uses regs[0] instead of orig_x0. ptrace should be
fine since it calls syscall_get_arguments() which uses orig_x0.

We could change the SC_ARM64_REGS_TO_ARGS macro though (in theory there
shouldn't be any performance hit as it's already cached).

>  
>  	cortex_a76_erratum_1463225_svc_handler();
>  	local_daif_restore(DAIF_PROCCTX);
>  	user_exit();
>  
> -	if (has_syscall_work(flags)) {
> -		/* set default errno for user-issued syscall(-1) */
> -		if (scno == NO_SYSCALL)
> -			regs->regs[0] = -ENOSYS;
> -		scno = syscall_trace_enter(regs);
> -		if (scno == NO_SYSCALL)
> -			goto trace_exit;
> -	}
> +	scno = syscall_enter_from_usermode(regs, scno);
> +	if (scno == NO_SYSCALL)
> +		goto trace_exit;
>  
>  	invoke_syscall(regs, scno, sc_nr, syscall_table);

-- 
Catalin

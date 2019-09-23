Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFEBAF96
	for <lists+linux-arch@lfdr.de>; Mon, 23 Sep 2019 10:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406304AbfIWIaz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Sep 2019 04:30:55 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40552 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404824AbfIWIay (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Sep 2019 04:30:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yXSriKdf2FrqGoCR9I7OdOZuAhyFtOG8Jie2xNu+Qls=; b=VzwT0cUXkN0GSRCz2/JwtuMAh
        Z7Sn1+WZMPND5nRp4JdjRM+pboRlnjlVp0m7JCE9HL8DKpYP11g5V003y9tj6Th7Ai5yAApnqmThB
        Tb2mft51o49fJsDcO28/Kt4uEVNTZ9UXe21c35InXGSVX6fyUQs3oVMSG5AIantxtRm2U0GUOc/88
        yN+DTdTdauaYhUELlFLNARTIxSEF9ud172OSbcu6fnc9hRauGAcVrv8mN92AT6juMzrGlpgf/SBgC
        BbfeMhvGhs3Al+zlngSNuBjWe+yKC1s3OL68RDrKckZjOSFPsDjAIxNynJQnPPvld6rU33RBEqJqO
        3zFTcbsnw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCJk6-0001O8-3y; Mon, 23 Sep 2019 08:30:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 09509305E43;
        Mon, 23 Sep 2019 10:29:57 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EA9932B1204C6; Mon, 23 Sep 2019 10:30:42 +0200 (CEST)
Date:   Mon, 23 Sep 2019 10:30:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [RFC patch 09/15] entry: Provide generic exit to usermode
 functionality
Message-ID: <20190923083042.GE2349@hirez.programming.kicks-ass.net>
References: <20190919150314.054351477@linutronix.de>
 <20190919150809.340471236@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919150809.340471236@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 19, 2019 at 05:03:23PM +0200, Thomas Gleixner wrote:
> +static unsigned long core_exit_to_usermode_work(struct pt_regs *regs,
> +						unsigned long ti_work)
> +{
> +	/*
> +	 * Before returning to user space ensure that all pending work
> +	 * items have been completed.
> +	 */
> +	while (ti_work & EXIT_TO_USERMODE_WORK) {
> +
> +		local_irq_enable_exit_to_user(ti_work);
> +
> +		if (ti_work & _TIF_NEED_RESCHED)
> +			schedule();
> +
> +		if (ti_work & _TIF_UPROBE)
> +			uprobe_notify_resume(regs);
> +
> +		if (ti_work & _TIF_PATCH_PENDING)
> +			klp_update_patch_state(current);
> +
> +		if (ti_work & _TIF_SIGPENDING)
> +			arch_do_signal(regs);
> +
> +		if (ti_work & _TIF_NOTIFY_RESUME) {
> +			clear_thread_flag(TIF_NOTIFY_RESUME);
> +			tracehook_notify_resume(regs);
> +			rseq_handle_notify_resume(NULL, regs);
> +		}
> +
> +		/* Architecture specific TIF work */
> +		arch_exit_to_usermode_work(regs, ti_work);
> +
> +		/*
> +		 * Disable interrupts and reevaluate the work flags as they
> +		 * might have changed while interrupts and preemption was
> +		 * enabled above.
> +		 */
> +		local_irq_disable_exit_to_user();
> +		ti_work = READ_ONCE(current_thread_info()->flags);
> +	}
> +	/*
> +	 * Was checked in exit_to_usermode_work() already, but the above
> +	 * loop might have wreckaged it.
> +	 */
> +	addr_limit_user_check();
> +	return ti_work;
> +}
> +
> +static void do_exit_to_usermode(struct pt_regs *regs)
> +{
> +	unsigned long ti_work = READ_ONCE(current_thread_info()->flags);
> +
> +	lockdep_sys_exit();
> +
> +	addr_limit_user_check();
> +
> +	if (unlikely(ti_work & EXIT_TO_USERMODE_WORK))
> +		ti_work = core_exit_to_usermode_work(regs, ti_work);

would it make sense to do:

	lockdep_sys_exit();
	addr_limit_user_check();

here instead of before core_exit_to_usermode_work(); that would also
allow getting rid of that second addr_limit_user_check() invocation.

And movind that lockdep check later would catch any of the
EXIT_TO_USERMODE_WORK users leaking a lock.

> +
> +	arch_exit_to_usermode(regs, ti_work);
> +	/* Return to userspace right after this which turns on interrupts */
> +	trace_hardirqs_on();
> +}

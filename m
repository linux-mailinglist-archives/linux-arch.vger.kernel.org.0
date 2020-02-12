Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD7CE15A75B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2020 12:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725887AbgBLLJI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Feb 2020 06:09:08 -0500
Received: from foss.arm.com ([217.140.110.172]:59306 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbgBLLJI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 12 Feb 2020 06:09:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4489030E;
        Wed, 12 Feb 2020 03:09:07 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9602E3F68F;
        Wed, 12 Feb 2020 03:09:05 -0800 (PST)
Date:   Wed, 12 Feb 2020 11:09:03 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Peter Collingbourne <pcc@google.com>
Cc:     Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] arm64: mte: Do not service syscalls after async tag fault
Message-ID: <20200212110903.GE488264@arrakis.emea.arm.com>
References: <20191217180152.GO5624@arrakis.emea.arm.com>
 <20191220013639.212396-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191220013639.212396-1-pcc@google.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Dec 19, 2019 at 05:36:39PM -0800, Peter Collingbourne wrote:
> When entering the kernel after an async tag fault due to a syscall, rather
> than for another reason (e.g. preemption), we don't want to service the
> syscall as it may mask the tag fault. Rewind the PC to the svc instruction
> in order to give a userspace signal handler an opportunity to handle the
> fault and resume, and skip all other syscall processing.
> 
> Signed-off-by: Peter Collingbourne <pcc@google.com>
> ---
[...]
>  arch/arm64/kernel/syscall.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index 9a9d98a443fc..49ea9bb47190 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -95,13 +95,29 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
>  {
>  	unsigned long flags = current_thread_info()->flags;
>  
> -	regs->orig_x0 = regs->regs[0];
> -	regs->syscallno = scno;
> -
>  	cortex_a76_erratum_1463225_svc_handler();
>  	local_daif_restore(DAIF_PROCCTX);
>  	user_exit();
>  
> +#ifdef CONFIG_ARM64_MTE
> +	if (flags & _TIF_MTE_ASYNC_FAULT) {
> +		/*
> +		 * We entered the kernel after an async tag fault due to a
> +		 * syscall, rather than for another reason (e.g. preemption).
> +		 * In this case, we don't want to service the syscall as it may
> +		 * mask the tag fault. Rewind the PC to the svc instruction in
> +		 * order to give a userspace signal handler an opportunity to
> +		 * handle the fault and resume, and skip all other syscall
> +		 * processing.
> +		 */
> +		regs->pc -= 4;
> +		return;
> +	}
> +#endif
> +
> +	regs->orig_x0 = regs->regs[0];
> +	regs->syscallno = scno;

I'm slightly worried about the interaction with single-step, other
signals. It might be better if we just use the existing syscall
restarting mechanism. Untested diff below:

-------------------8<-------------------------------
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index a12c0c88d345..db25f5d6a07c 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -102,6 +102,16 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	local_daif_restore(DAIF_PROCCTX);
 	user_exit();
 
+	if (system_supports_mte() && (flags & _TIF_MTE_ASYNC_FAULT)) {
+		/*
+		 * Process the asynchronous tag check fault before the actual
+		 * syscall. do_notify_resume() will send a signal to userspace
+		 * before the syscall is restarted.
+		 */
+		regs->regs[0] = -ERESTARTNOINTR;
+		return;
+	}
+
 	if (has_syscall_work(flags)) {
 		/* set default errno for user-issued syscall(-1) */
 		if (scno == NO_SYSCALL)

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEBB2CBF7C
	for <lists+linux-arch@lfdr.de>; Wed,  2 Dec 2020 15:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730371AbgLBOV0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Dec 2020 09:21:26 -0500
Received: from foss.arm.com ([217.140.110.172]:41436 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726729AbgLBOV0 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 2 Dec 2020 09:21:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B42AC30E;
        Wed,  2 Dec 2020 06:20:40 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.23.201])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E8933F718;
        Wed,  2 Dec 2020 06:20:35 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:20:33 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Alex Belits <abelits@marvell.com>
Cc:     "nitesh@redhat.com" <nitesh@redhat.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        Prasun Kapoor <pkapoor@marvell.com>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "trix@redhat.com" <trix@redhat.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "mtosatti@redhat.com" <mtosatti@redhat.com>,
        "will@kernel.org" <will@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "leon@sidebranch.com" <leon@sidebranch.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pauld@redhat.com" <pauld@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v5 7/9] task_isolation: don't interrupt CPUs with
 tick_nohz_full_kick_cpu()
Message-ID: <20201202142033.GD66958@C02TD0UTHF1T.local>
References: <8d887e59ca713726f4fcb25a316e1e932b02823e.camel@marvell.com>
 <76ed0b222d2f16fb5aebd144ac0222a7f3b87fa1.camel@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76ed0b222d2f16fb5aebd144ac0222a7f3b87fa1.camel@marvell.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 23, 2020 at 05:58:22PM +0000, Alex Belits wrote:
> From: Yuri Norov <ynorov@marvell.com>
> 
> For nohz_full CPUs the desirable behavior is to receive interrupts
> generated by tick_nohz_full_kick_cpu(). But for hard isolation it's
> obviously not desirable because it breaks isolation.
> 
> This patch adds check for it.
> 
> Signed-off-by: Yuri Norov <ynorov@marvell.com>
> [abelits@marvell.com: updated, only exclude CPUs running isolated tasks]
> Signed-off-by: Alex Belits <abelits@marvell.com>
> ---
>  kernel/time/tick-sched.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index a213952541db..6c8679e200f0 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/stat.h>
>  #include <linux/sched/nohz.h>
> +#include <linux/isolation.h>
>  #include <linux/module.h>
>  #include <linux/irq_work.h>
>  #include <linux/posix-timers.h>
> @@ -268,7 +269,8 @@ static void tick_nohz_full_kick(void)
>   */
>  void tick_nohz_full_kick_cpu(int cpu)
>  {
> -	if (!tick_nohz_full_cpu(cpu))
> +	smp_rmb();

What does this barrier pair with? The commit message doesn't mention it,
and it's not clear in-context.

Thanks,
Mark.

> +	if (!tick_nohz_full_cpu(cpu) || task_isolation_on_cpu(cpu))
>  		return;
>  
>  	irq_work_queue_on(&per_cpu(nohz_full_kick_work, cpu), cpu);
> -- 
> 2.20.1
> 

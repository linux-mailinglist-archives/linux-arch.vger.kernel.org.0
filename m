Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E758048C73B
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240342AbiALPaO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 10:30:14 -0500
Received: from mail.efficios.com ([167.114.26.124]:45310 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiALPaN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 10:30:13 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 22C2E256BDD;
        Wed, 12 Jan 2022 10:30:13 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FgnNHSu8dnr9; Wed, 12 Jan 2022 10:30:12 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8F892256AEB;
        Wed, 12 Jan 2022 10:30:12 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8F892256AEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642001412;
        bh=FnjYGuW0I6zePvbFToYHzlP8DS7O3w/YZ1ZXt1qnQKA=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=jKjykU50H5eae74ibaB/cAXnFSuAa2E6occ7fIGzxQO+ndWwh+uEaey2TnkDtA6Nz
         Pe39DyN7AFCcfaIgkwxRaINkIJgtELyt/vi68ho2S1IQDc3TDy5xzcC0tV8szL9Y2G
         cHDmrqUfah9kKYQ53KMfmXxvVW0vdl4BfN4908RAQqJus47TmNjDSqs/e34PFxbZJF
         Oahhe0jOOvPsOIgeu+3o4MZllwxPGrckJqHXFq8zzCjktVdeL17a5CKGbQK3KeLhzg
         8sW8R0OeYFbdAcfGJIX/ImDdfnTaBBihYdNEm4W2Z1z4ES8AraCOIpIHU74Po/2ASR
         EN9qJXFwtzuqg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 705R5bQp08E7; Wed, 12 Jan 2022 10:30:12 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 76716256AE7;
        Wed, 12 Jan 2022 10:30:12 -0500 (EST)
Date:   Wed, 12 Jan 2022 10:30:12 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@ozlabs.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>, x86 <x86@kernel.org>,
        riel <riel@surriel.com>, Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nadav Amit <nadav.amit@gmail.com>
Message-ID: <1540361433.24669.1642001412433.JavaMail.zimbra@efficios.com>
In-Reply-To: <d64b6651fe8799481c6204e43b17f81010018345.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org> <d64b6651fe8799481c6204e43b17f81010018345.1641659630.git.luto@kernel.org>
Subject: Re: [PATCH 01/23] membarrier: Document why membarrier() works
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: membarrier: Document why membarrier() works
Thread-Index: D+wnsFtNq5E2V/nPUcM/w4t9b/BIaA==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jan 8, 2022, at 11:43 AM, Andy Lutomirski luto@kernel.org wrote:

> We had a nice comment at the top of membarrier.c explaining why membarrier
> worked in a handful of scenarios, but that consisted more of a list of
> things not to forget than an actual description of the algorithm and why it
> should be expected to work.
> 
> Add a comment explaining my understanding of the algorithm.  This exposes a
> couple of implementation issues that I will hopefully fix up in subsequent
> patches.

Given that no explanation about the specific implementation issues is provided
here, I would be tempted to remove the last sentence above, and keep that for
the commit messages of the subsequent patches.

The explanation you add here is clear and very much fits my mental model, thanks!

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> 
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> kernel/sched/membarrier.c | 60 +++++++++++++++++++++++++++++++++++++--
> 1 file changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index b5add64d9698..30e964b9689d 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -7,8 +7,64 @@
> #include "sched.h"
> 
> /*
> - * For documentation purposes, here are some membarrier ordering
> - * scenarios to keep in mind:
> + * The basic principle behind the regular memory barrier mode of
> + * membarrier() is as follows.  membarrier() is called in one thread.  Tt
> + * iterates over all CPUs, and, for each CPU, it either sends an IPI to
> + * that CPU or it does not. If it sends an IPI, then we have the
> + * following sequence of events:
> + *
> + * 1. membarrier() does smp_mb().
> + * 2. membarrier() does a store (the IPI request payload) that is observed by
> + *    the target CPU.
> + * 3. The target CPU does smp_mb().
> + * 4. The target CPU does a store (the completion indication) that is observed
> + *    by membarrier()'s wait-for-IPIs-to-finish request.
> + * 5. membarrier() does smp_mb().
> + *
> + * So all pre-membarrier() local accesses are visible after the IPI on the
> + * target CPU and all pre-IPI remote accesses are visible after
> + * membarrier(). IOW membarrier() has synchronized both ways with the target
> + * CPU.
> + *
> + * (This has the caveat that membarrier() does not interrupt the CPU that it's
> + * running on at the time it sends the IPIs. However, if that is the CPU on
> + * which membarrier() starts and/or finishes, membarrier() does smp_mb() and,
> + * if not, then the scheduler's migration of membarrier() is a full barrier.)
> + *
> + * membarrier() skips sending an IPI only if membarrier() sees
> + * cpu_rq(cpu)->curr->mm != target mm.  The sequence of events is:
> + *
> + *           membarrier()            |          target CPU
> + * ---------------------------------------------------------------------
> + *                                   | 1. smp_mb()
> + *                                   | 2. set rq->curr->mm = other_mm
> + *                                   |    (by writing to ->curr or to ->mm)
> + * 3. smp_mb()                       |
> + * 4. read rq->curr->mm == other_mm  |
> + * 5. smp_mb()                       |
> + *                                   | 6. rq->curr->mm = target_mm
> + *                                   |    (by writing to ->curr or to ->mm)
> + *                                   | 7. smp_mb()
> + *                                   |
> + *
> + * All memory accesses on the target CPU prior to scheduling are visible
> + * to membarrier()'s caller after membarrier() returns due to steps 1, 2, 4
> + * and 5.
> + *
> + * All memory accesses by membarrier()'s caller prior to membarrier() are
> + * visible to the target CPU after scheduling due to steps 3, 4, 6, and 7.
> + *
> + * Note that, tasks can change their ->mm, e.g. via kthread_use_mm().  So
> + * tasks that switch their ->mm must follow the same rules as the scheduler
> + * changing rq->curr, and the membarrier() code needs to do both dereferences
> + * carefully.
> + *
> + * GLOBAL_EXPEDITED support works the same way except that all references
> + * to rq->curr->mm are replaced with references to rq->membarrier_state.
> + *
> + *
> + * Specific examples of how this produces the documented properties of
> + * membarrier():
>  *
>  * A) Userspace thread execution after IPI vs membarrier's memory
>  *    barrier before sending the IPI
> --
> 2.33.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com

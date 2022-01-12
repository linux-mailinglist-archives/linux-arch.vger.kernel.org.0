Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF4F48C7FC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jan 2022 17:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbiALQNn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 12 Jan 2022 11:13:43 -0500
Received: from mail.efficios.com ([167.114.26.124]:60272 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240511AbiALQNm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 12 Jan 2022 11:13:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 3D76625724E;
        Wed, 12 Jan 2022 11:13:42 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id oua0xcW-gUeM; Wed, 12 Jan 2022 11:13:42 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E84FB2574CA;
        Wed, 12 Jan 2022 11:13:41 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com E84FB2574CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1642004021;
        bh=4vn/hFKG6knqUORtHXUNl85gRLBGKGI5ehyXZmeHqiE=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=nypU3HUYqIBGW8Ug/4thPwW+6ZNBoxBGJ5vAS/oGyRU3w1zsewn5/0zNCS2ErMBsC
         5eOjQvarxqF7Tehg3LrybrjVz543f9r1MFzcBgs9fyG2Qx4s1Kk1rl1PUd0lsP3rAn
         LigLGhFWyNUql6qbltmbg5lm+7WF8G1dzoFxkSn7iuOulhDqth4K5BGNgXLRONIft7
         gCeW65+QlWeKXgxh+5dNka6VZJGE+7Mq4K6eW2I7K3ZRCAe5PKR9WJTXIvJZ/vT4ab
         CLThBc1hHIt6jJlIWT88pvxr1RqWhVdJmecFqBn7QxlPtZsD877wf5lREBjtTRw+4f
         agzuFVgRDbtDA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9B90cHwpQFb2; Wed, 12 Jan 2022 11:13:41 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id D721A2572E7;
        Wed, 12 Jan 2022 11:13:41 -0500 (EST)
Date:   Wed, 12 Jan 2022 11:13:41 -0500 (EST)
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
Message-ID: <1680283915.24784.1642004021846.JavaMail.zimbra@efficios.com>
In-Reply-To: <f7ab552d8b7f00ec33766f4bf8554c8fc67517bc.1641659630.git.luto@kernel.org>
References: <cover.1641659630.git.luto@kernel.org> <f7ab552d8b7f00ec33766f4bf8554c8fc67517bc.1641659630.git.luto@kernel.org>
Subject: Re: [PATCH 08/23] membarrier: Remove redundant clear of
 mm->membarrier_state in exec_mmap()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4180 (ZimbraWebClient - FF96 (Linux)/8.8.15_GA_4177)
Thread-Topic: membarrier: Remove redundant clear of mm->membarrier_state in exec_mmap()
Thread-Index: yWF6Tz08UZu1y1sGy8W9Q/hxbmkICg==
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

----- On Jan 8, 2022, at 11:43 AM, Andy Lutomirski luto@kernel.org wrote:

> exec_mmap() supplies a brand-new mm from mm_alloc(), and membarrier_state
> is already 0.  There's no need to clear it again.

Then I suspect we might want to tweak the comment just above the memory barrier ?

        /*
         * Issue a memory barrier before clearing membarrier_state to
         * guarantee that no memory access prior to exec is reordered after
         * clearing this state.
         */

Is that barrier still needed ?

Thanks,

Mathieu

> 
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---
> kernel/sched/membarrier.c | 1 -
> 1 file changed, 1 deletion(-)
> 
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index eb73eeaedc7d..c38014c2ed66 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -285,7 +285,6 @@ void membarrier_exec_mmap(struct mm_struct *mm)
> 	 * clearing this state.
> 	 */
> 	smp_mb();
> -	atomic_set(&mm->membarrier_state, 0);
> 	/*
> 	 * Keep the runqueue membarrier_state in sync with this mm
> 	 * membarrier_state.
> --
> 2.33.1

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com




Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 998BE144E1E
	for <lists+linux-arch@lfdr.de>; Wed, 22 Jan 2020 09:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbgAVI6Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Jan 2020 03:58:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:51684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgAVI6Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 22 Jan 2020 03:58:25 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A0542253D;
        Wed, 22 Jan 2020 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579683503;
        bh=wYfcRaLJtEbKOeSJp7ItR4eKrQug0zW9UUl6qHernP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKakU8GByrZCSyz/lp4L7EWEwgj4wGOJ0MiaU0u/6ItkamUgJaDGJIa3LpGcFOQAz
         7iV8+yNHR0KUR9v7iY5R0Fyt3hKLJBcbbz6cuqFNugxPBUcgcyEJHPzizZSpcwa19R
         R7FB7VvMAUYdGy6k/fp4nO2uE8tC5IPlsDo/+ER4=
Date:   Wed, 22 Jan 2020 08:58:17 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alex Kogan <alex.kogan@oracle.com>, linux-arch@vger.kernel.org,
        guohanjun@huawei.com, arnd@arndb.de, dave.dice@oracle.com,
        jglauber@marvell.com, x86@kernel.org, will.deacon@arm.com,
        linux@armlinux.org.uk, steven.sistare@oracle.com,
        linux-kernel@vger.kernel.org, rahul.x.yadav@oracle.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, longman@redhat.com,
        tglx@linutronix.de, daniel.m.jordan@oracle.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 3/5] locking/qspinlock: Introduce CNA into the slow
 path of qspinlock
Message-ID: <20200122085816.GB15537@willie-the-truck>
References: <20191125210709.10293-1-alex.kogan@oracle.com>
 <20191125210709.10293-4-alex.kogan@oracle.com>
 <20200121202919.GM11457@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121202919.GM11457@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 21, 2020 at 09:29:19PM +0100, Peter Zijlstra wrote:
> 
> various notes and changes in the below.
> 
> ---
> 
> Index: linux-2.6/kernel/locking/qspinlock.c
> ===================================================================
> --- linux-2.6.orig/kernel/locking/qspinlock.c
> +++ linux-2.6/kernel/locking/qspinlock.c
> @@ -598,10 +598,10 @@ EXPORT_SYMBOL(queued_spin_lock_slowpath)
>  #define _GEN_CNA_LOCK_SLOWPATH
>  
>  #undef pv_wait_head_or_lock
> -#define pv_wait_head_or_lock		cna_pre_scan
> +#define pv_wait_head_or_lock		cna_wait_head_or_lock
>  
>  #undef try_clear_tail
> -#define try_clear_tail			cna_try_change_tail
> +#define try_clear_tail			cna_try_clear_tail
>  
>  #undef mcs_pass_lock
>  #define mcs_pass_lock			cna_pass_lock
> Index: linux-2.6/kernel/locking/qspinlock_cna.h
> ===================================================================
> --- linux-2.6.orig/kernel/locking/qspinlock_cna.h
> +++ linux-2.6/kernel/locking/qspinlock_cna.h
> @@ -8,37 +8,37 @@
>  /*
>   * Implement a NUMA-aware version of MCS (aka CNA, or compact NUMA-aware lock).
>   *
> - * In CNA, spinning threads are organized in two queues, a main queue for
> + * In CNA, spinning threads are organized in two queues, a primary queue for
>   * threads running on the same NUMA node as the current lock holder, and a
> - * secondary queue for threads running on other nodes. Schematically, it
> - * looks like this:
> + * secondary queue for threads running on other nodes. Schematically, it looks
> + * like this:
>   *
>   *    cna_node
> - *   +----------+    +--------+        +--------+
> - *   |mcs:next  | -> |mcs:next| -> ... |mcs:next| -> NULL      [Main queue]
> - *   |mcs:locked| -+ +--------+        +--------+
> + *   +----------+     +--------+         +--------+
> + *   |mcs:next  | --> |mcs:next| --> ... |mcs:next| --> NULL  [Primary queue]
> + *   |mcs:locked| -.  +--------+         +--------+
>   *   +----------+  |
> - *                 +----------------------+
> - *                                        \/
> + *                 `----------------------.
> + *                                        v
>   *                 +--------+         +--------+
> - *                 |mcs:next| -> ...  |mcs:next|          [Secondary queue]
> + *                 |mcs:next| --> ... |mcs:next|            [Secondary queue]
>   *                 +--------+         +--------+
>   *                     ^                    |
> - *                     +--------------------+
> + *                     `--------------------'
>   *
> - * N.B. locked = 1 if secondary queue is absent. Othewrise, it contains the
> + * N.B. locked := 1 if secondary queue is absent. Othewrise, it contains the

If we're redoing the comment, please can you s/Othewrise/Otherwise/ at the
same time? It catches me every time I read it!

Will

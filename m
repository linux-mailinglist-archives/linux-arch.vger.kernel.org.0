Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1633A713
	for <lists+linux-arch@lfdr.de>; Sun, 14 Mar 2021 18:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbhCNRBu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 14 Mar 2021 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234051AbhCNRBa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 14 Mar 2021 13:01:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9646C061574
        for <linux-arch@vger.kernel.org>; Sun, 14 Mar 2021 10:01:29 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lLU7F-00G3Ph-4e; Sun, 14 Mar 2021 18:01:21 +0100
Message-ID: <d1d37b2a05fe0ebffca23e1aff1c7f6a5a5d87fd.camel@sipsolutions.net>
Subject: Re: [RFC v8 09/20] um: lkl: kernel thread support
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org,
        jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc:     tavi.purdila@gmail.com, linux-kernel-library@freelists.org,
        linux-arch@vger.kernel.org, retrage01@gmail.com
Date:   Sun, 14 Mar 2021 18:01:20 +0100
In-Reply-To: <3aecd66b9314f2b435fb6df029dc5829bf8c50ff.1611103406.git.thehajime@gmail.com>
References: <cover.1611103406.git.thehajime@gmail.com>
         <3aecd66b9314f2b435fb6df029dc5829bf8c50ff.1611103406.git.thehajime@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 2021-01-20 at 11:27 +0900, Hajime Tazaki wrote:

> +void __weak subarch_cpu_idle(void)
> +{
> +}
> +
>  void arch_cpu_idle(void)
>  {
>  	cpu_tasks[current_thread_info()->cpu].pid = os_getpid();
>  	um_idle_sleep();
> +	subarch_cpu_idle();


Not sure that belongs into this patch in the first place, but wouldn't
it make some sense to move the um_idle_sleep() into the
subarch_cpu_idle() so LKL (or apps using it) can get full control?

> +/*
> + * This structure is used to get access to the "LKL CPU" that allows us to run
> + * Linux code. Because we have to deal with various synchronization requirements
> + * between idle thread, system calls, interrupts, "reentrancy", CPU shutdown,
> + * imbalance wake up (i.e. acquire the CPU from one thread and release it from
> + * another), we can't use a simple synchronization mechanism such as (recursive)
> + * mutex or semaphore. Instead, we use a mutex and a bunch of status data plus a
> + * semaphore.
> + */

Honestly, some of that documentation, and perhaps even the whole API for
LKL feels like it should come earlier in the series.

E.g. now here I see all those lkl_mutex_lock() (where btw documentation
doesn't always match the function name), so you *don't* have the
function ops pointer struct anymore?

It'd be nice to have some high-level view of what applications *must*
do, and what they *can* do, at the beginning of this series.

> +	 *
> +	 * This algorithm assumes that we never have more the MAX_THREADS
> +	 * requesting CPU access.
> +	 */
> +	#define MAX_THREADS 1000000

What implications does that value have? It seems several orders of
magnitude too large?

> +static int __cpu_try_get_lock(int n)
> +{
> +	lkl_thread_t self;
> +
> +	if (__sync_fetch_and_add(&cpu.shutdown_gate, n) >= MAX_THREADS)
> +		return -2;

Feels like that could be some kind of enum here instead of -2 and -1 and
all that magic.

> +	/* when somebody holds a lock, sleep until released,
> +	 * with obtaining a semaphore (cpu.sem)
> +	 */

nit: /*
      * use this comment style
      */

> +void switch_threads(jmp_buf *me, jmp_buf *you)
> +{
> +	/* NOP */
> +}

Why, actually?

Again, goes back to the high-level design thing I alluded to above, but
it's not clear to me why you need idle (which implies you're running the
scheduler) but not this (which implies you're *not* running the
scheduler)?

johannes


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1144E958F
	for <lists+linux-arch@lfdr.de>; Mon, 28 Mar 2022 13:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbiC1LqL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Mar 2022 07:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243298AbiC1Lom (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Mar 2022 07:44:42 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AA0574AA;
        Mon, 28 Mar 2022 04:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uSPQzhJnBZpuInXUZRxeTEHXo//rS4RqH+94/ELlhDM=; b=Y319biAt5K6nejbSVQElCizcwH
        KshO/fhWzu1hp+KwOwUryrxbQeDmHHG3cgOxCgoW7piq2YJneFquQHl2Ypc/fz8B2txGisxU35L2R
        N+iwuANB4NrRgWyUv6i38FoskJay75oaezYExrIXi0UX84c0fbRbQuG77f++ywMi423bOYWytesMe
        NF8/Yem5KYG3fpVA9WSly7w6tnLfdCmR+0P9a/P0TmqVb3D/pukv4HvUBP4c5QCf/50ts4JAY5Z/U
        +BunOWmHS1ASn87GsmDEGL2Y5TnieEE6dGFQbHJi9xxwfX/Sf9Ek/OaluB4mUZhT+B5MgM6Aszsgr
        g4H6fshw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nYnit-005Qev-7a; Mon, 28 Mar 2022 11:39:47 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 509969861E7; Mon, 28 Mar 2022 13:39:46 +0200 (CEST)
Date:   Mon, 28 Mar 2022 13:39:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220328113946.GA8939@worktop.programming.kicks-ass.net>
References: <20220322185709.141236-1-namhyung@kernel.org>
 <20220322185709.141236-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322185709.141236-3-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 22, 2022 at 11:57:09AM -0700, Namhyung Kim wrote:
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index ee2fd7614a93..c88deda77cf2 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -644,6 +644,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  	}
>  
>  	set_current_state(state);
> +	trace_contention_begin(lock, 0);
>  	for (;;) {
>  		bool first;
>  
> @@ -710,6 +711,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  skip_wait:
>  	/* got the lock - cleanup and rejoice! */
>  	lock_acquired(&lock->dep_map, ip);
> +	trace_contention_end(lock, 0);
>  
>  	if (ww_ctx)
>  		ww_mutex_lock_acquired(ww, ww_ctx);

(note: it's possible to get to this trace_contention_end() without ever
having passed a _begin -- fixed in the below)

> @@ -721,6 +723,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
>  err:
>  	__set_current_state(TASK_RUNNING);
>  	__mutex_remove_waiter(lock, &waiter);
> +	trace_contention_end(lock, ret);
>  err_early_kill:
>  	raw_spin_unlock(&lock->wait_lock);
>  	debug_mutex_free_waiter(&waiter);


So there was one thing here, that might or might not be important, but
is somewhat inconsistent with the whole thing. That is, do you want to
include optimistic spinning in the contention time or not?

Because currently you do it sometimes.

Also, if you were to add LCB_F_MUTEX then you could have something like:


--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -602,12 +602,14 @@ __mutex_lock_common(struct mutex *lock,
 	preempt_disable();
 	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
 
+	trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, NULL)) {
 		/* got the lock, yay! */
 		lock_acquired(&lock->dep_map, ip);
 		if (ww_ctx)
 			ww_mutex_set_context_fastpath(ww, ww_ctx);
+		trace_contention_end(lock, 0);
 		preempt_enable();
 		return 0;
 	}
@@ -644,7 +646,7 @@ __mutex_lock_common(struct mutex *lock,
 	}
 
 	set_current_state(state);
-	trace_contention_begin(lock, 0);
+	trace_contention_begin(lock, LCB_F_MUTEX);
 	for (;;) {
 		bool first;
 
@@ -684,10 +686,16 @@ __mutex_lock_common(struct mutex *lock,
 		 * state back to RUNNING and fall through the next schedule(),
 		 * or we must see its unlock and acquire.
 		 */
-		if (__mutex_trylock_or_handoff(lock, first) ||
-		    (first && mutex_optimistic_spin(lock, ww_ctx, &waiter)))
+		if (__mutex_trylock_or_handoff(lock, first))
 			break;
 
+		if (first) {
+			trace_contention_begin(lock, LCB_F_MUTEX | LCB_F_SPIN);
+			if (mutex_optimistic_spin(lock, ww_ctx, &waiter))
+				break;
+			trace_contention_begin(lock, LCB_F_MUTEX);
+		}
+
 		raw_spin_lock(&lock->wait_lock);
 	}
 	raw_spin_lock(&lock->wait_lock);
@@ -723,8 +731,8 @@ __mutex_lock_common(struct mutex *lock,
 err:
 	__set_current_state(TASK_RUNNING);
 	__mutex_remove_waiter(lock, &waiter);
-	trace_contention_end(lock, ret);
 err_early_kill:
+	trace_contention_end(lock, ret);
 	raw_spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);

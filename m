Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5CC4DDF43
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 17:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233905AbiCRQpP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 12:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbiCRQpP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 12:45:15 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFB325E32B;
        Fri, 18 Mar 2022 09:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n32rgjP/yXbwdJvAGnm4un77KkghAXw5J0rcdgYFEwE=; b=QaXW0TKkaRn4ogxp5y8lTjILNH
        OQzo5+PUAwOnKCcNGrboJ6stcnq9DOUbuVXYAZL6e0LG+c9pxWnQwUyJgmPlxj9DjQNoafks27pXR
        SUrpOmQILEA9/371YJ17dWpkYPYSxvizY12WwQjB3SOu8PuggBa8mhwm5wxqrZkMg9ijgS3vczrdJ
        3DgbIc2q5+5cEx0SxEpjI0TTJbWyAH2mfZDsJeousMDVXUYZ7uaJMmWrURD5I4H8HQNWPpFjYQSm+
        n4alG9/UaaC4PhF/d2/cu5G2Bbkl+qmNv5TTMhBUEKQOZqIbRjo1PIjELldEtEhG4lp249fMzWFkc
        s+BWtUUw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nVFhK-00872d-8j; Fri, 18 Mar 2022 16:43:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DAF4A30007E;
        Fri, 18 Mar 2022 17:43:26 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 71C2A200B82FA; Fri, 18 Mar 2022 17:43:26 +0100 (CET)
Date:   Fri, 18 Mar 2022 17:43:26 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
References: <20220316224548.500123-1-namhyung@kernel.org>
 <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjSBRNxzaE9c+F/1@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Mar 18, 2022 at 08:55:32PM +0800, Boqun Feng wrote:
> On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
> [...]
> > @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> >  								long timeout)
> >  {
> >  	struct semaphore_waiter waiter;
> > +	bool tracing = false;
> >  
> >  	list_add_tail(&waiter.list, &sem->wait_list);
> >  	waiter.task = current;
> > @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
> >  		if (unlikely(timeout <= 0))
> >  			goto timed_out;
> >  		__set_current_state(state);
> > +		if (!tracing) {
> > +			trace_contention_begin(sem, 0);
> 
> This looks a littl ugly ;-/ Maybe we can rename __down_common() to
> ___down_common() and implement __down_common() as:
> 
> 	static inline int __sched __down_common(...)
> 	{
> 		int ret;
> 		trace_contention_begin(sem, 0);
> 		ret = ___down_common(...);
> 		trace_contention_end(sem, ret);
> 		return ret;
> 	}
> 
> Thoughts?

Yeah, that works, except I think he wants a few extra
__set_current_state()'s like so:

diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
index 9ee381e4d2a4..e2049a7e0ea4 100644
--- a/kernel/locking/semaphore.c
+++ b/kernel/locking/semaphore.c
@@ -205,8 +205,7 @@ struct semaphore_waiter {
  * constant, and thus optimised away by the compiler.  Likewise the
  * 'timeout' parameter for the cases without timeouts.
  */
-static inline int __sched __down_common(struct semaphore *sem, long state,
-								long timeout)
+static __always_inline int ___down_common(struct semaphore *sem, long state, long timeout)
 {
 	struct semaphore_waiter waiter;
 
@@ -227,15 +226,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
 			return 0;
 	}
 
- timed_out:
+timed_out:
 	list_del(&waiter.list);
 	return -ETIME;
 
- interrupted:
+interrupted:
 	list_del(&waiter.list);
 	return -EINTR;
 }
 
+static __always_inline int __down_common(struct semaphore *sem, long state, long timeout)
+{
+	int ret;
+
+	__set_current_state(state);
+	trace_contention_begin(sem, 0);
+	ret = ___down_common(sem, state, timeout);
+	__set_current_state(TASK_RUNNING);
+	trace_contention_end(sem, ret);
+
+	return ret;
+}
+
 static noinline void __sched __down(struct semaphore *sem)
 {
 	__down_common(sem, TASK_UNINTERRUPTIBLE, MAX_SCHEDULE_TIMEOUT);

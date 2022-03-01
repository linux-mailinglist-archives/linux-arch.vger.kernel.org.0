Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161FB4C8E1E
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 15:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbiCAOqO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 09:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbiCAOqI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 09:46:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667F93CA6C;
        Tue,  1 Mar 2022 06:45:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED9D9615F1;
        Tue,  1 Mar 2022 14:45:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C200AC340EE;
        Tue,  1 Mar 2022 14:45:24 +0000 (UTC)
Date:   Tue, 1 Mar 2022 09:45:23 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220301094523.5e4bc77d@gandalf.local.home>
In-Reply-To: <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
References: <20220301010412.431299-1-namhyung@kernel.org>
        <20220301010412.431299-3-namhyung@kernel.org>
        <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 1 Mar 2022 10:03:54 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> index 8555c4efe97c..18b9f4bf6f34 100644
> --- a/kernel/locking/rtmutex.c
> +++ b/kernel/locking/rtmutex.c
> @@ -1579,6 +1579,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
>  
>  	set_current_state(state);
>  
> +	trace_contention_begin(lock, _RET_IP_, LCB_F_RT);

I guess one issue with this is that _RET_IP_ will return the rt_mutex
address if this is not inlined, making the _RET_IP_ rather useless.

Now, if we can pass the _RET_IP_ into __rt_mutex_slowlock() then we could
reference that.

-- Steve


> +
>  	ret = task_blocks_on_rt_mutex(lock, waiter, current, ww_ctx, chwalk);
>  	if (likely(!ret))
>  		ret = rt_mutex_slowlock_block(lock, ww_ctx, state, NULL, waiter);
> @@ -1601,6 +1603,9 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
>  	 * unconditionally. We might have to fix that up.
>  	 */
>  	fixup_rt_mutex_waiters(lock);
> +
> +	trace_contention_end(lock, ret);
> +
>  	return ret;
>  }

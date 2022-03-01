Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C24F34C86CA
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 09:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbiCAIo5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 03:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCAIo4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 03:44:56 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD9F7DA84;
        Tue,  1 Mar 2022 00:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ada8xpo23wBI1pn03oUM0wmOJBiudB2NMaqAB+HG05s=; b=mWdnCWfHHw4SvGH/OxiIK0T/Wj
        BhWT1rlS3oKQnPYWAOvMAyc346EtkfGkty3jEvzzDSRzrHJoxui2ywx+xDrnlrulV+Mcqf8pHeL54
        IHK5LKW/xnw842B4j+9eEvq3ZZYqFJscSwIfy0m+tZEp9VMp1rqTI5t7EVXVIPFw0ac5Ja1KDpH/2
        HGeGQFED0ZSugTPa2JUxhJMqg5iCSPnlfTwwsV0wFM2ahMHU40VL7rI6SuAqv2kLN01xQ4oRM3cCa
        uLQ1IpJt0J5TqOLZama4B+2juAN3mvT0yvSUE27uZtYoKFN7gSpUYjvMjahxDppPRQpS1qC+Lb5BI
        Ip7EXerw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOy6k-00EClk-P6; Tue, 01 Mar 2022 08:43:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6BA8F30017F;
        Tue,  1 Mar 2022 09:43:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 29C742024C933; Tue,  1 Mar 2022 09:43:44 +0100 (CET)
Date:   Tue, 1 Mar 2022 09:43:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        bpf@vger.kernel.org, Radoslaw Burny <rburny@google.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow
 path
Message-ID: <Yh3cwBloddIGvCjU@hirez.programming.kicks-ass.net>
References: <20220301010412.431299-1-namhyung@kernel.org>
 <20220301010412.431299-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301010412.431299-3-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 28, 2022 at 05:04:10PM -0800, Namhyung Kim wrote:
> @@ -80,7 +81,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
>  		return;
>  
>  	/* The slowpath will decrement the reader count, if necessary. */
> +	LOCK_CONTENTION_BEGIN(lock, LCB_F_READ);
>  	queued_read_lock_slowpath(lock);
> +	LOCK_CONTENTION_END(lock);
>  }
>  
>  /**
> @@ -94,7 +97,9 @@ static inline void queued_write_lock(struct qrwlock *lock)
>  	if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
>  		return;
>  
> +	LOCK_CONTENTION_BEGIN(lock, LCB_F_WRITE);
>  	queued_write_lock_slowpath(lock);
> +	LOCK_CONTENTION_END(lock);
>  }

> @@ -82,7 +83,9 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
>  	if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
>  		return;
>  
> +	LOCK_CONTENTION_BEGIN(lock, 0);
>  	queued_spin_lock_slowpath(lock, val);
> +	LOCK_CONTENTION_END(lock);
>  }

Can you please stick that _inside_ the slowpath? You really don't want
to inline that.

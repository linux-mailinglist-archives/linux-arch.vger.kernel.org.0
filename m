Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8116A4DCD76
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 19:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiCQSVI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 14:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiCQSVH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 14:21:07 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27895220B0D;
        Thu, 17 Mar 2022 11:19:51 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id v4so5584387pjh.2;
        Thu, 17 Mar 2022 11:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+g2oRiO3uzZ+DA2WGg9ZB5KEZZCxlDqRy1Fc/qJpJHM=;
        b=lkJD3Zm5NwTqW+OB6itNq0cJY20QN8LbaRZAYvK7alxragMTGwPhdS9iO7nmWkBOy2
         MjsatpMGaQXFhOHpx1v6LjY+q+TCChmWqMxvOudQbXhc1UyIVR03eV7mjJeqwzF2sEta
         b6PN3jGtXXncNejO64PCuaKIB28Ez7ZJe17gspBe8ubYbt9Yjnze0dFFMJGav/Hb0FBv
         hbw8rEj0CzXMzDmNfqWiaCco1SwwYnt9GCLdKXMnlSErPfDrNnE07wRkVkLo+S2/Mwfj
         Kg15gvo5MnjUcBcIQH3AWYfpO0pC/vfQFMzT3IY4p0/MX+i7I2DrkpThbDrq7unfDgWV
         qQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+g2oRiO3uzZ+DA2WGg9ZB5KEZZCxlDqRy1Fc/qJpJHM=;
        b=jfiY9uIXQ6lbRkFnRtm6INNJ4KLCAObcuC91n4qlvPhae/gb1gQAf18jWqVmfIZRBc
         /r0YYho8Mp5tOKUcawoBFYXbTOWHKq0r3eGFuHnUlWgRdGs4vPy1/wi6YXhuesfU9X3h
         /zBmP8K5KhEm3oW36nCAV4d1USV5iCl4LZt7RgtKdwTEwBR7uPoMsGgKiOzMvqZSegM6
         hxeKPrUa5b/z6qsacWRNDyD+zC1+8C4L7wT3MjZyTJziCp+11tk8xg/S85synIH2bE9Q
         JyIr4KpBBFKeWMJP0IkL0aTODG6xOKnagtj1GzIpol/pcmYH+T024aVvfH7go+6Hnilj
         niPQ==
X-Gm-Message-State: AOAM531pA79YZqqK3JTYPaTynEiJtow8l1Q5wMZH0lcl0/BA6u0VacCe
        5kzymHW5lWQl0GyWHfzIrIw=
X-Google-Smtp-Source: ABdhPJwsbPBANPJBlFrJblkjlzz7zEPKAqYuZHhFZ20KssMtVJM6PS+PLrLUUJut6hAlL7oOBwoTKA==
X-Received: by 2002:a17:90a:8581:b0:1b2:7541:af6c with SMTP id m1-20020a17090a858100b001b27541af6cmr7004158pjn.48.1647541190705;
        Thu, 17 Mar 2022 11:19:50 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a0026ca00b004fa06fa407asm7647668pfw.91.2022.03.17.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:19:50 -0700 (PDT)
Date:   Thu, 17 Mar 2022 18:19:44 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
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
        bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <YjN7wPMEBVIuOiGN@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220316224548.500123-1-namhyung@kernel.org>
 <20220316224548.500123-3-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316224548.500123-3-namhyung@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 16, 2022 at 03:45:48PM -0700, Namhyung Kim wrote:
> Adding the lock contention tracepoints in various lock function slow
> paths.  Note that each arch can define spinlock differently, I only
> added it only to the generic qspinlock for now.
> 
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  kernel/locking/mutex.c        |  3 +++
>  kernel/locking/percpu-rwsem.c |  3 +++
>  kernel/locking/qrwlock.c      |  9 +++++++++
>  kernel/locking/qspinlock.c    |  5 +++++
>  kernel/locking/rtmutex.c      | 11 +++++++++++
>  kernel/locking/rwbase_rt.c    |  3 +++
>  kernel/locking/rwsem.c        |  9 +++++++++
>  kernel/locking/semaphore.c    | 14 +++++++++++++-
>  8 files changed, 56 insertions(+), 1 deletion(-)
>

[...]

> diff --git a/kernel/locking/semaphore.c b/kernel/locking/semaphore.c
> index 9ee381e4d2a4..e3c19668dfee 100644
> --- a/kernel/locking/semaphore.c
> +++ b/kernel/locking/semaphore.c
> @@ -32,6 +32,7 @@
>  #include <linux/semaphore.h>
>  #include <linux/spinlock.h>
>  #include <linux/ftrace.h>
> +#include <trace/events/lock.h>
>  
>  static noinline void __down(struct semaphore *sem);
>  static noinline int __down_interruptible(struct semaphore *sem);
> @@ -209,6 +210,7 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
>  								long timeout)
>  {
>  	struct semaphore_waiter waiter;
> +	bool tracing = false;
>  
>  	list_add_tail(&waiter.list, &sem->wait_list);
>  	waiter.task = current;
> @@ -220,18 +222,28 @@ static inline int __sched __down_common(struct semaphore *sem, long state,
>  		if (unlikely(timeout <= 0))
>  			goto timed_out;
>  		__set_current_state(state);
> +		if (!tracing) {
> +			trace_contention_begin(sem, 0);
> +			tracing = true;
> +		}
>  		raw_spin_unlock_irq(&sem->lock);
>  		timeout = schedule_timeout(timeout);
>  		raw_spin_lock_irq(&sem->lock);
> -		if (waiter.up)
> +		if (waiter.up) {
> +			trace_contention_end(sem, 0);
>  			return 0;
> +		}
>  	}
>  
>   timed_out:
> +	if (tracing)
> +		trace_contention_end(sem, -ETIME);
>  	list_del(&waiter.list);
>  	return -ETIME;
>  
>   interrupted:
> +	if (tracing)
> +		trace_contention_end(sem, -EINTR);
>  	list_del(&waiter.list);
>  	return -EINTR;
>  }

why not simply remove tracing variable and call trace_contention_begin()
earlier like in rwsem? we can ignore it if ret != 0.

-- 
Thank you, You are awesome!
Hyeonggon :-)

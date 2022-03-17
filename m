Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 300EE4DCC83
	for <lists+linux-arch@lfdr.de>; Thu, 17 Mar 2022 18:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236918AbiCQRdw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Mar 2022 13:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbiCQRdv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Mar 2022 13:33:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C51F215473;
        Thu, 17 Mar 2022 10:32:34 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mz9-20020a17090b378900b001c657559290so5878393pjb.2;
        Thu, 17 Mar 2022 10:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y9kDZyBLJx9F2sokCzBB2rgv0e0X4fXeqPnAK6E43Es=;
        b=RPNCjduZtrjFDAESwV1khKPDQxo0hrGv21f1taOPzfmekuFc0NkhoiHqEHRYBW+hhW
         IPvPw8M6DrfMJ/UU26LlNVisaCCvv/A9DzWS7iZetGTWloHYcIy7kB7GBnqQ1Z2rZtHw
         BI9aphEiIz2+2V/LvFCpqKq6k8SBt8A0hlkAFPTnmQ2BOWUEt16T2wfRH4qCykk/iCyy
         QYEeMfkVbH4uHDQEl08drWnBR8DiWPJ+Da7VG2W6dn3HSaVNvGvPH5XMZYzABZ+a44P+
         a5YD8RCAC5b4kzq8ITTwyPc/F5Jtto4xGW66jbRPTF/25KCu4dTKbQhJIXZa40IK4KTn
         tYOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y9kDZyBLJx9F2sokCzBB2rgv0e0X4fXeqPnAK6E43Es=;
        b=Yex1Cdd6iihiAwDW7PIYdmTsGcB87ogh0uXDbBilcoyRu9P5wEA1hp7BTPwSAGD718
         P0b7wK7xoETMho4anBsBHW1v1e24D0V4g2D2z3MfX+Z6Yo7xIzVnCAhpRl4dDKIMzhCf
         J3blyCaeTy6YMAbkQhIk0tqYcIkVpjLLW6BTx6wOlFXVd6nnSA41xzl6lHNjkEcD68V3
         BgM/DWuz7VVcxV13hijv27dHvQ3YNf74A3GG4Wn0SSWe5VtNo4EStn4P9OY7eK9qyxGc
         BMLvE4Y77CFMaajyV+/OSEj/dyC6wgBDrM46mvs/yTsMz+lHL2MEtpZwxzJGhxFB4T56
         EeRw==
X-Gm-Message-State: AOAM531ckvafZBgQ6SPVDDVGoFA7yWXuKHEf1354f+lH7FZ6KFsVGDNo
        T/gcpORFS3c4meJnywoC6cDFm468iK+gpA==
X-Google-Smtp-Source: ABdhPJxy1DqphVWg5+m54ayVprt+lukWMGB2ln/4J0KcZjs6Vyj7WxXPx7wp26NxxRGKK5nXF6AApQ==
X-Received: by 2002:a17:90b:2486:b0:1bc:9d6a:f22 with SMTP id nt6-20020a17090b248600b001bc9d6a0f22mr17221522pjb.211.1647538353967;
        Thu, 17 Mar 2022 10:32:33 -0700 (PDT)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id d11-20020aa7868b000000b004f768dfe93asm6967081pfo.176.2022.03.17.10.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 10:32:33 -0700 (PDT)
Date:   Thu, 17 Mar 2022 17:32:27 +0000
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
Subject: Re: [PATCH 0/2] locking: Add new lock contention tracepoints (v3)
Message-ID: <YjNwq+YrUULI/3QC@ip-172-31-19-208.ap-northeast-1.compute.internal>
References: <20220316224548.500123-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316224548.500123-1-namhyung@kernel.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 16, 2022 at 03:45:46PM -0700, Namhyung Kim wrote:
> Hello,
> 
> There have been some requests for low-overhead kernel lock contention
> monitoring.  The kernel has CONFIG_LOCK_STAT to provide such an infra
> either via /proc/lock_stat or tracepoints directly.
> 
> However it's not light-weight and hard to be used in production.  So
> I'm trying to add new tracepoints for lock contention and using them
> as a base to build a new monitoring system.

Hello Namhyung,
I like this series so much.
Lock contentions became much more visible without serious overhead.

For the series:
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

How would you use these tracepoints, is there a script you use?
For testing, I just wrote a simple bpftrace script:

$ sudo bpftrace -e 'BEGIN
{
	printf("Collecting lockstats... Hit Ctrl-C to end.\n");
}

tracepoint:lock:contention_begin
{
	@start_us[tid] = nsecs / 1000;
}

tracepoint:lock:contention_end
{
	if (args->ret == 0) {
		@stats[kstack] = hist(nsecs / 1000 - @start_us[tid]);
	}
}

END
{
	clear(@start_us);
}'

And it shows its distribution of slowpath wait time like below. Great.

@stats[
    __traceiter_contention_end+76
    __traceiter_contention_end+76
    queued_spin_lock_slowpath+556
    _raw_spin_lock+108
    rmqueue_bulk+80
    rmqueue+1060
    get_page_from_freelist+372
    __alloc_pages+208
    alloc_pages_vma+160
    alloc_zeroed_user_highpage_movable+72
    do_anonymous_page+92
    handle_pte_fault+320
    __handle_mm_fault+252
    handle_mm_fault+244
    do_page_fault+340
    do_translation_fault+100
    do_mem_abort+76
    el0_da+60
    el0t_64_sync_handler+232
    el0t_64_sync+420
]:
[2, 4)                 1 |@                                                   |
[4, 8)                30 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     |
[8, 16)               25 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             |
[16, 32)              33 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32, 64)              29 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
[64, 128)             13 |@@@@@@@@@@@@@@@@@@@@                                |
[128, 256)             2 |@@@                                                 |


@stats[
    __traceiter_contention_end+76
    __traceiter_contention_end+76
    rwsem_down_write_slowpath+1216
    down_write_killable+100
    do_mprotect_pkey.constprop.0+176
    __arm64_sys_mprotect+40
    invoke_syscall+80
    el0_svc_common.constprop.0+76
    do_el0_svc+52
    el0_svc+48
    el0t_64_sync_handler+164
    el0t_64_sync+420
]: 
[1]                   13 |@@@@@@@@@@@                                         |
[2, 4)                42 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                |
[4, 8)                 5 |@@@@                                                |
[8, 16)               10 |@@@@@@@@                                            |
[16, 32)              60 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32, 64)              41 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                 |
[64, 128)             40 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
[128, 256)            14 |@@@@@@@@@@@@                                        |
[256, 512)             7 |@@@@@@                                              |
[512, 1K)              6 |@@@@@                                               |
[1K, 2K)               2 |@                                                   |
[2K, 4K)               1 |                                                    |

@stats[
    __traceiter_contention_end+76
    __traceiter_contention_end+76
    queued_spin_lock_slowpath+556
    _raw_spin_lock+108
    futex_wake+168
    do_futex+200
    __arm64_sys_futex+112
    invoke_syscall+80
    el0_svc_common.constprop.0+76
    do_el0_svc+52
    el0_svc+48
    el0t_64_sync_handler+164
    el0t_64_sync+420
]:
[0]                    3 |                                                    |
[1]                 2515 |@                                                   |
[2, 4)              8747 |@@@@@                                               |
[4, 8)             17052 |@@@@@@@@@@                                          |
[8, 16)            46706 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
[16, 32)           82105 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[32, 64)           46918 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
[64, 128)             99 |                                                    |
[128, 256)             1 |                                                    |
[256, 512)             8 |                                                    |
[512, 1K)              0 |                                                    |
[1K, 2K)               0 |                                                    |
[2K, 4K)               0 |                                                    |
[4K, 8K)               0 |                                                    |
[8K, 16K)              0 |                                                    |
[16K, 32K)             5 |                                                    |
[32K, 64K)            12 |                                                    |
[64K, 128K)           34 |                                                    |
[128K, 256K)          68 |                                                    |
[256K, 512K)           7 |                                                    |


> * Changes in v3
>  - move the tracepoints deeper in the slow path
>  - remove the caller ip
>  - don't use task state in the flags
> 
> * Changes in v2
>  - do not use lockdep infrastructure
>  - add flags argument to lock:contention_begin tracepoint
> 
> I added a flags argument in the contention_begin to classify locks in
> question.  It can tell whether it's a spinlock, reader-writer lock or
> a mutex.  With stacktrace, users can identify which lock is contended.
>
> The patch 01 added the tracepoints and move the definition to the
> mutex.c file so that it can see the tracepoints without lockdep.
> 
> The patch 02 actually installs the tracepoints in the locking code.
> To minimize the overhead, they were added in the slow path of the code
> separately.  As spinlocks are defined in the arch headers, I couldn't
> handle them all.  I've just added it to generic queued spinlock and
> rwlocks only.  Each arch can add the tracepoints later.
>
> This series base on the current tip/locking/core and you get it from
> 'locking/tracepoint-v3' branch in my tree at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> 
> 
> Thanks,
> Namhyung
> 
> 
> Namhyung Kim (2):
>   locking: Add lock contention tracepoints
>   locking: Apply contention tracepoints in the slow path
> 
>  include/trace/events/lock.h   | 54 +++++++++++++++++++++++++++++++++--
>  kernel/locking/lockdep.c      |  1 -
>  kernel/locking/mutex.c        |  6 ++++
>  kernel/locking/percpu-rwsem.c |  3 ++
>  kernel/locking/qrwlock.c      |  9 ++++++
>  kernel/locking/qspinlock.c    |  5 ++++
>  kernel/locking/rtmutex.c      | 11 +++++++
>  kernel/locking/rwbase_rt.c    |  3 ++
>  kernel/locking/rwsem.c        |  9 ++++++
>  kernel/locking/semaphore.c    | 14 ++++++++-
>  10 files changed, 110 insertions(+), 5 deletions(-)
> 
> 
> base-commit: cd27ccfc727e99352321c0c75012ab9c5a90321e
> -- 
> 2.35.1.894.gb6a874cedc-goog
> 

-- 
Thank you, You are awesome!
Hyeonggon :-)

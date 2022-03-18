Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935DC4DE34E
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 22:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239272AbiCRVOS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240990AbiCRVOM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 17:14:12 -0400
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF3D53A49;
        Fri, 18 Mar 2022 14:12:52 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id p15so5228579lfk.8;
        Fri, 18 Mar 2022 14:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ksuX6MNNVKcpHa2cJxv8Npehy7dLW5BZP8Nd24HsaFA=;
        b=XSCNq5gPxnqtXW1aGcvA1pn28uVm8lQZLYralUh8/p8/vPtEeeQN2nrW67DCYZEtL4
         pdxeZ+ZKHgDTzBFmPDkn0xuitRVLqzN/ibCiPrF8uTNYa38e/5VZgY6XZuQCmbDGAT39
         Ic8V+U0QrzKv9cJYGHdoqKKSZHcDHG+LDon862LyGZFk4WJRBN6Y0oywSB39FHp8KOCW
         O3yIu9L4edG1p4WuKrdxI8uS9N/kG5IdVhvlqf2AK5B0HWMt1U1Z8GyaL4pjXcQnAqVE
         v747Cn+ROgiNB4x8KqqUUGRWlU3xO99cphcH/5Fk6L0r3DfG7Z0KXLtzBSKTJzFwll9W
         94RQ==
X-Gm-Message-State: AOAM532CjMjuyCqC52iGPwjnAIm+h0vY9MKmlYiT3qsWDYMjJYVHv3Ae
        bJJV1P48osQKvQ/+6By7N0hmSGyy46xQ9IXi6Kg=
X-Google-Smtp-Source: ABdhPJwAoZP/Evj9WuqznTWvuq6qRzv5hLg45b2J0BU02fW2LyOukiW0H/T59dTOSxGuzYiY/OINHNMgru0MhYiP1ts=
X-Received: by 2002:a05:6512:1195:b0:448:4fcc:34f2 with SMTP id
 g21-20020a056512119500b004484fcc34f2mr6997466lfr.454.1647637971048; Fri, 18
 Mar 2022 14:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <YjNwq+YrUULI/3QC@ip-172-31-19-208.ap-northeast-1.compute.internal>
In-Reply-To: <YjNwq+YrUULI/3QC@ip-172-31-19-208.ap-northeast-1.compute.internal>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Mar 2022 14:12:39 -0700
Message-ID: <CAM9d7cjgN2BM4Jy9R=18=0eRJkLdi5SB2EbqELLLnbnxOJJ12g@mail.gmail.com>
Subject: Re: [PATCH 0/2] locking: Add new lock contention tracepoints (v3)
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
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
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hello Hyeonggon,

On Thu, Mar 17, 2022 at 10:32 AM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Wed, Mar 16, 2022 at 03:45:46PM -0700, Namhyung Kim wrote:
> > Hello,
> >
> > There have been some requests for low-overhead kernel lock contention
> > monitoring.  The kernel has CONFIG_LOCK_STAT to provide such an infra
> > either via /proc/lock_stat or tracepoints directly.
> >
> > However it's not light-weight and hard to be used in production.  So
> > I'm trying to add new tracepoints for lock contention and using them
> > as a base to build a new monitoring system.
>
> Hello Namhyung,
> I like this series so much.
> Lock contentions became much more visible without serious overhead.
>
> For the series:
> Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Thanks!

>
> How would you use these tracepoints, is there a script you use?

Not yet.  But I'm thinking something similar to your script.
Probably I'll extend 'perf lock' command to have this kind of output
but it doesn't have lock name and use avg/min/max time instead of
histogram.

Thanks,
Namhyung


> For testing, I just wrote a simple bpftrace script:
>
> $ sudo bpftrace -e 'BEGIN
> {
>         printf("Collecting lockstats... Hit Ctrl-C to end.\n");
> }
>
> tracepoint:lock:contention_begin
> {
>         @start_us[tid] = nsecs / 1000;
> }
>
> tracepoint:lock:contention_end
> {
>         if (args->ret == 0) {
>                 @stats[kstack] = hist(nsecs / 1000 - @start_us[tid]);
>         }
> }
>
> END
> {
>         clear(@start_us);
> }'
>
> And it shows its distribution of slowpath wait time like below. Great.
>
> @stats[
>     __traceiter_contention_end+76
>     __traceiter_contention_end+76
>     queued_spin_lock_slowpath+556
>     _raw_spin_lock+108
>     rmqueue_bulk+80
>     rmqueue+1060
>     get_page_from_freelist+372
>     __alloc_pages+208
>     alloc_pages_vma+160
>     alloc_zeroed_user_highpage_movable+72
>     do_anonymous_page+92
>     handle_pte_fault+320
>     __handle_mm_fault+252
>     handle_mm_fault+244
>     do_page_fault+340
>     do_translation_fault+100
>     do_mem_abort+76
>     el0_da+60
>     el0t_64_sync_handler+232
>     el0t_64_sync+420
> ]:
> [2, 4)                 1 |@                                                   |
> [4, 8)                30 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@     |
> [8, 16)               25 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@             |
> [16, 32)              33 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32, 64)              29 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@       |
> [64, 128)             13 |@@@@@@@@@@@@@@@@@@@@                                |
> [128, 256)             2 |@@@                                                 |
>
>
> @stats[
>     __traceiter_contention_end+76
>     __traceiter_contention_end+76
>     rwsem_down_write_slowpath+1216
>     down_write_killable+100
>     do_mprotect_pkey.constprop.0+176
>     __arm64_sys_mprotect+40
>     invoke_syscall+80
>     el0_svc_common.constprop.0+76
>     do_el0_svc+52
>     el0_svc+48
>     el0t_64_sync_handler+164
>     el0t_64_sync+420
> ]:
> [1]                   13 |@@@@@@@@@@@                                         |
> [2, 4)                42 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                |
> [4, 8)                 5 |@@@@                                                |
> [8, 16)               10 |@@@@@@@@                                            |
> [16, 32)              60 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32, 64)              41 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                 |
> [64, 128)             40 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                  |
> [128, 256)            14 |@@@@@@@@@@@@                                        |
> [256, 512)             7 |@@@@@@                                              |
> [512, 1K)              6 |@@@@@                                               |
> [1K, 2K)               2 |@                                                   |
> [2K, 4K)               1 |                                                    |
>
> @stats[
>     __traceiter_contention_end+76
>     __traceiter_contention_end+76
>     queued_spin_lock_slowpath+556
>     _raw_spin_lock+108
>     futex_wake+168
>     do_futex+200
>     __arm64_sys_futex+112
>     invoke_syscall+80
>     el0_svc_common.constprop.0+76
>     do_el0_svc+52
>     el0_svc+48
>     el0t_64_sync_handler+164
>     el0t_64_sync+420
> ]:
> [0]                    3 |                                                    |
> [1]                 2515 |@                                                   |
> [2, 4)              8747 |@@@@@                                               |
> [4, 8)             17052 |@@@@@@@@@@                                          |
> [8, 16)            46706 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
> [16, 32)           82105 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [32, 64)           46918 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
> [64, 128)             99 |                                                    |
> [128, 256)             1 |                                                    |
> [256, 512)             8 |                                                    |
> [512, 1K)              0 |                                                    |
> [1K, 2K)               0 |                                                    |
> [2K, 4K)               0 |                                                    |
> [4K, 8K)               0 |                                                    |
> [8K, 16K)              0 |                                                    |
> [16K, 32K)             5 |                                                    |
> [32K, 64K)            12 |                                                    |
> [64K, 128K)           34 |                                                    |
> [128K, 256K)          68 |                                                    |
> [256K, 512K)           7 |                                                    |
>

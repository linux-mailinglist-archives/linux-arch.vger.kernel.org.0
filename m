Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132D24D8EF9
	for <lists+linux-arch@lfdr.de>; Mon, 14 Mar 2022 22:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245310AbiCNVp3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Mar 2022 17:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237993AbiCNVp2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Mar 2022 17:45:28 -0400
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA256193ED;
        Mon, 14 Mar 2022 14:44:17 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id g17so29643280lfh.2;
        Mon, 14 Mar 2022 14:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2VfnhbEGoaJMBxbZk/tXhcsK9P2W1Pv5LMv/tBwaIfo=;
        b=gqFwpR5aJyOGQqvePQE5NWYaKTi370jQjW/2L/ts1xGaTpQ4QfjMv+JqadXeoG2FTw
         mjp1/0l276dQdWj/+SRBx3x0JzTYWYjo8c4L+LrpDDADSeG3+OtxwjaDk2t9gMNeZEho
         +wKDwLsEcpCd2B83UZCr4tVfMAmfnMZT/GDyZvP2Bimk8rK7XtyH/p80yBFLOhITHEzx
         x1fpZ3uqS8IDwy8jtaY3fLCbmByDlTjfOBCKcupRPfVllV2Gx3WH9lEAnjjodGsQvPfj
         5g9YiexxqUSOXfGWlFWHBJ+yIZsbsOM257QOpd+c1lGPNgAVdIkoPxhU4MAzVMJe8L7d
         thjg==
X-Gm-Message-State: AOAM533ZKh0AX2An3UQlx45daYnlDk8VY/k5RknXre2Ug1mNCEN89VtA
        EDEihZWJWhLfhFNclONFHrOxQaGAEI7/AGcVg8Q=
X-Google-Smtp-Source: ABdhPJwxEXoBr4ZBfHBu6jBT617TwgtgRa+XqjNS61tSGsjG05PbvU4akXVAa/APfYJL6iDAN9GZoTYHduL2i9Q84ZU=
X-Received: by 2002:a19:6b0d:0:b0:448:53c6:702b with SMTP id
 d13-20020a196b0d000000b0044853c6702bmr14479332lfa.528.1647294256086; Mon, 14
 Mar 2022 14:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220301010412.431299-1-namhyung@kernel.org> <20220301010412.431299-3-namhyung@kernel.org>
 <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 14 Mar 2022 14:44:04 -0700
Message-ID: <CAM9d7ciHObwkvyy9Uz5NRb=KBY-HtXAtAJTgXocA6C42aBoAyg@mail.gmail.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow path
To:     Peter Zijlstra <peterz@infradead.org>
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
        bpf <bpf@vger.kernel.org>, Radoslaw Burny <rburny@google.com>
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

On Tue, Mar 1, 2022 at 1:04 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 28, 2022 at 05:04:10PM -0800, Namhyung Kim wrote:
> > @@ -1718,9 +1726,11 @@ static __always_inline void __sched rtlock_slowlock(struct rt_mutex_base *lock)
> >  {
> >       unsigned long flags;
> >
> > +     trace_contention_begin(lock, _RET_IP_, LCB_F_RT | TASK_RTLOCK_WAIT);
> >       raw_spin_lock_irqsave(&lock->wait_lock, flags);
> >       rtlock_slowlock_locked(lock);
> >       raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
> > +     trace_contention_end(lock);
> >  }
>
> Same, if you do it one level in, you can have the tracepoint itself look
> at current->__state.

So I tried this by reading the state in the trace like below:

+       TP_fast_assign(
+               __entry->lock_addr = lock;
+               __entry->flags = flags | get_current_state();
+       ),

But I sometimes see unrelated values which contain
__TASK_TRACED or __TASK_STOPPED and some unexpected values
like TASK_UNINTERRUPTIBLE for rwlocks.  Maybe I missed something.

Anyway I think it's confusing and complicates things unnecessarily.
Probably it'd better using new flags like LCB_F_SPIN and LCB_F_WAIT.

Thanks,
Namhyung

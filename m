Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336BD4C92B9
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 19:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbiCASPL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 13:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiCASPJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 13:15:09 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04016514C;
        Tue,  1 Mar 2022 10:14:17 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id w27so28304626lfa.5;
        Tue, 01 Mar 2022 10:14:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ati6pz51+/93fkjrp3qu8EZp+J9aKKrBiRYbSU6Fg0U=;
        b=Om1b/3NSga/xQw9wOdywHI2V9HI8m4djhIgNTKV3srkMs4k0nk+2GOvMb2tndm9t5g
         twyHsKrnN511CmtFTobiO4r5Zp78Yy1vXEEh+J/Ro/yKd0pMORUeoixw/56M8Yywlnkc
         Uhy3Kkaj8p3pXXSVHdDWsndVxzWADMj7G6WOjVo8aklMX+TWNORD1ljunV8N41n66E0B
         3/Km1TkKz0nodT5N/m/GO8uCK9OLXYLUf5EYuGS70p1qjYrLReKtCzek70GybFfi2i7j
         oFDcbM7o6Ho+Avai07riui3B6AWFiQQUnQnv+x7sdOtPx4aaOiafUmZrs+Rvl/U2zDkA
         QrMA==
X-Gm-Message-State: AOAM5321BECP3ZttYhVGCgeX7GIhqGX5B3f0lTBtJ0xqKwWdHAP3WuqX
        LVeZrvIMtb20lN1g0S9ibsODiJqo8HG8lOWHCsU=
X-Google-Smtp-Source: ABdhPJwwTCy5Iu77Y+Yoc3pN2nsGqYdY3FbTWRPKg/kzAovjLy1lxlN7CbrtLeLiVxVccp2ScsWZHip7IloooCUnZqM=
X-Received: by 2002:ac2:58d8:0:b0:442:bc4b:afb7 with SMTP id
 u24-20020ac258d8000000b00442bc4bafb7mr15934522lfo.99.1646158456152; Tue, 01
 Mar 2022 10:14:16 -0800 (PST)
MIME-Version: 1.0
References: <20220301010412.431299-1-namhyung@kernel.org> <20220301010412.431299-3-namhyung@kernel.org>
 <Yh3heodejlBiwqLj@hirez.programming.kicks-ass.net> <20220301094523.5e4bc77d@gandalf.local.home>
In-Reply-To: <20220301094523.5e4bc77d@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Mar 2022 10:14:05 -0800
Message-ID: <CAM9d7ci_8JsvA2U8fLxON0y+5cATmJH5xUZgzWnbAkXLumO2bw@mail.gmail.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow path
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
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

Hi Steve,

On Tue, Mar 1, 2022 at 6:45 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 1 Mar 2022 10:03:54 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
> > index 8555c4efe97c..18b9f4bf6f34 100644
> > --- a/kernel/locking/rtmutex.c
> > +++ b/kernel/locking/rtmutex.c
> > @@ -1579,6 +1579,8 @@ static int __sched __rt_mutex_slowlock(struct rt_mutex_base *lock,
> >
> >       set_current_state(state);
> >
> > +     trace_contention_begin(lock, _RET_IP_, LCB_F_RT);
>
> I guess one issue with this is that _RET_IP_ will return the rt_mutex
> address if this is not inlined, making the _RET_IP_ rather useless.
>
> Now, if we can pass the _RET_IP_ into __rt_mutex_slowlock() then we could
> reference that.

Right, that's what I did in patch 03 and 04 for mutex and rwsem.
But I forgot to update rt_mutex, will fix.

Thanks,
Namhyung

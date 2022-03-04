Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136154CCF0B
	for <lists+linux-arch@lfdr.de>; Fri,  4 Mar 2022 08:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbiCDH3n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Mar 2022 02:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbiCDH3n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Mar 2022 02:29:43 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D165A1;
        Thu,  3 Mar 2022 23:28:52 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id m14so12638410lfu.4;
        Thu, 03 Mar 2022 23:28:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YgcBgxM/33mXus47pIGMzwpsQpru5dt8KhwXXP66SyI=;
        b=K4Q8TCU7BSm/H+PF3eNN9Ibb+tYUhXk8XSbhBSo2U/2DHwN71N50ljFmr2Fmhxf1tH
         IjS4liuKbH9I+Nvko14moUMuHirAQzbt4IDEjXf/kVvEMLfSR0L4eg8vcYLIrCXSKoLX
         iLLPs7dSMBrEseCo3195NVmC3T36dRktcHhu86VXQf0eryw7zrdbRKp/cPXC7++/oEBF
         a6+GQkwj4cNSJfOnecOdku5+6+ziqDJbFfEep1seThPtk/g6h5+2I4VQWJXPih4ie59Q
         RU5DUYIeazeWbYdtiF6xioqwtAMgs3RccTvvrSCpzguiu0RKAuJ9NKL/82ha4lCJ1oBo
         A8HA==
X-Gm-Message-State: AOAM530KF62D+PF95nUd5hIo+H4I+WDPuEnYhrJ8tSrEbsQte0KTNAbr
        MY5yf30y8OfXkpELp3UiJO+CfeP+9YJpgQP+JRs=
X-Google-Smtp-Source: ABdhPJxDY6x4O+YoxOBjIVgvcNrjoQxKXoMzBc4XWqzvtRyFNrqvqedcF2/GV9/jRLHOkv4+W9wBJzzgEgL7a7xB4p4=
X-Received: by 2002:a05:6512:33d6:b0:43b:8dc3:130f with SMTP id
 d22-20020a05651233d600b0043b8dc3130fmr24512452lfg.47.1646378930321; Thu, 03
 Mar 2022 23:28:50 -0800 (PST)
MIME-Version: 1.0
References: <20220301010412.431299-1-namhyung@kernel.org> <20220301010412.431299-4-namhyung@kernel.org>
 <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net> <20220301095354.0c2b7008@gandalf.local.home>
 <20220301194720.GJ11184@worktop.programming.kicks-ass.net>
In-Reply-To: <20220301194720.GJ11184@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 3 Mar 2022 23:28:38 -0800
Message-ID: <CAM9d7chroDP+UGfjEq+Cis4N6Y=ukNGJssNN8dQsLW-CTRZZpg@mail.gmail.com>
Subject: Re: [PATCH 3/4] locking/mutex: Pass proper call-site ip
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
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

On Tue, Mar 1, 2022 at 11:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Tue, Mar 01, 2022 at 09:53:54AM -0500, Steven Rostedt wrote:
> > On Tue, 1 Mar 2022 10:05:12 +0100
> > Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > On Mon, Feb 28, 2022 at 05:04:11PM -0800, Namhyung Kim wrote:
> > > > The __mutex_lock_slowpath() and friends are declared as noinline and
> > > > _RET_IP_ returns its caller as mutex_lock which is not meaningful.
> > > > Pass the ip from mutex_lock() to have actual caller info in the trace.
> > >
> > > Blergh, can't you do a very limited unwind when you do the tracing
> > > instead? 3 or 4 levels should be plenty fast and sufficient.
> >
> > Is there a fast and sufficient way that works across architectures?
>
> The normal stacktrace API? Or the fancy new arch_stack_walk() which is
> already available on most architectures you actually care about and
> risc-v :-)
>
> Remember, this is the contention path, we're going to stall anyway,
> doing a few levels of unwind shouldn't really hurt at that point.
>
> Anyway; when I wrote that this morning, I was thinking:
>
>         unsigned long ips[4];
>         stack_trace_save(ips, 4, 0);

When I collected stack traces in a BPF, it already consumed 3 or 4
entries in the BPF so I had to increase the size to 8 and skip 4.
But it didn't add noticeable overheads in my test.

Thanks,
Namhyung

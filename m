Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306554DE3E1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 23:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiCRWJQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 18:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiCRWJQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 18:09:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA921AD99;
        Fri, 18 Mar 2022 15:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E91DCB825D6;
        Fri, 18 Mar 2022 22:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF76C340E8;
        Fri, 18 Mar 2022 22:07:51 +0000 (UTC)
Date:   Fri, 18 Mar 2022 18:07:50 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Radoslaw Burny <rburny@google.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow
 path
Message-ID: <20220318180750.744f08d4@gandalf.local.home>
In-Reply-To: <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com>
References: <20220316224548.500123-1-namhyung@kernel.org>
        <20220316224548.500123-3-namhyung@kernel.org>
        <YjSBRNxzaE9c+F/1@boqun-archlinux>
        <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
        <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com>
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

On Fri, 18 Mar 2022 14:55:27 -0700
Namhyung Kim <namhyung@kernel.org> wrote:

> > > This looks a littl ugly ;-/ Maybe we can rename __down_common() to
> > > ___down_common() and implement __down_common() as:
> > >
> > >       static inline int __sched __down_common(...)
> > >       {
> > >               int ret;
> > >               trace_contention_begin(sem, 0);
> > >               ret = ___down_common(...);
> > >               trace_contention_end(sem, ret);
> > >               return ret;
> > >       }
> > >
> > > Thoughts?  
> >
> > Yeah, that works, except I think he wants a few extra
> > __set_current_state()'s like so:  
> 
> Not anymore, I decided not to because of noise in the task state.
> 
> Also I'm considering two tracepoints for the return path to reduce
> the buffer size as Mathieu suggested.  Normally it'd return with 0
> so we can ignore it in the contention_end.  For non-zero cases,
> we can add a new tracepoint to save the return value.

I don't think you need two tracepoints, but one that you can override.

We have eprobes that let you create a trace event on top of a current trace
event that can limit or extend what is traced in the buffer.

And I also have custom events that can be placed on top of any existing
tracepoint that has full access to what is sent into the tracepoint on not
just what is available to the trace event:

  https://lore.kernel.org/all/20220312232551.181178712@goodmis.org/

-- Steve

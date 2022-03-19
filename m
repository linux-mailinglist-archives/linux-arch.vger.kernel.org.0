Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E284DE4C2
	for <lists+linux-arch@lfdr.de>; Sat, 19 Mar 2022 01:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241614AbiCSAN3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 20:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235207AbiCSAN2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 20:13:28 -0400
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599B22F09FA;
        Fri, 18 Mar 2022 17:12:07 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id q5so13156665ljb.11;
        Fri, 18 Mar 2022 17:12:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RefRx5po0WHZQRy5R4kPGcVNk3NZW9epOkJFzUWcdCM=;
        b=voMGWsSsW9PVH18lzz2o1FiGKYOCoFdP9pYQCBJ5FloBVmP0kIQETHTirgBiOpXKCX
         u2OSEL1KPa+xzSWFKp+3HbIdpnSOtIXo2YbxjseCdkypWbxFyuRCGh5DFv/XqUcitzNk
         1Qo+FS8Kn1zYtd0dB8bBTIdFJ0bDt2dkdlICEY4Iplgborrtyx3Q0oNy2DHU0DGdepxD
         GGpwjuKFjpbAwu1l1y8zjDK287CbmUP/9vUKFPv51CN63zwX46z6Apk8ZVuuwpmPxEQV
         oueQ4eYOfEd/6OvBuey2zhJyso6LWzB8W12BMRm7Bt7dc51qhhoeD5VDsSirZERqY/7R
         Osfw==
X-Gm-Message-State: AOAM532qhM/xHEyc4VmlHUm99lfwsLbAFapv95lcwH93LzqS8G1smWvG
        XLXVjGKzH0Hwr+nLSUyykX/D5hmLNQ+AwGIb0k4=
X-Google-Smtp-Source: ABdhPJyfkYN6A81HjzmJTCnynG8RKBtKMXJZnaNF5lbqXCG4MD+NtaaJEofHQBy7mJLyD8zPsbitqKp3/8sBZMUGMWE=
X-Received: by 2002:a2e:82c5:0:b0:247:e81f:8b02 with SMTP id
 n5-20020a2e82c5000000b00247e81f8b02mr7698337ljh.90.1647648725489; Fri, 18 Mar
 2022 17:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux> <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
 <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com> <20220318180750.744f08d4@gandalf.local.home>
In-Reply-To: <20220318180750.744f08d4@gandalf.local.home>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Mar 2022 17:11:54 -0700
Message-ID: <CAM9d7ci-91efxreUvLBhkAcs0rpngzR9+3BnZBDb4zLai2Ewcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Steven Rostedt <rostedt@goodmis.org>
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

On Fri, Mar 18, 2022 at 3:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 18 Mar 2022 14:55:27 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > > > This looks a littl ugly ;-/ Maybe we can rename __down_common() to
> > > > ___down_common() and implement __down_common() as:
> > > >
> > > >       static inline int __sched __down_common(...)
> > > >       {
> > > >               int ret;
> > > >               trace_contention_begin(sem, 0);
> > > >               ret = ___down_common(...);
> > > >               trace_contention_end(sem, ret);
> > > >               return ret;
> > > >       }
> > > >
> > > > Thoughts?
> > >
> > > Yeah, that works, except I think he wants a few extra
> > > __set_current_state()'s like so:
> >
> > Not anymore, I decided not to because of noise in the task state.
> >
> > Also I'm considering two tracepoints for the return path to reduce
> > the buffer size as Mathieu suggested.  Normally it'd return with 0
> > so we can ignore it in the contention_end.  For non-zero cases,
> > we can add a new tracepoint to save the return value.
>
> I don't think you need two tracepoints, but one that you can override.
>
> We have eprobes that let you create a trace event on top of a current trace
> event that can limit or extend what is traced in the buffer.
>
> And I also have custom events that can be placed on top of any existing
> tracepoint that has full access to what is sent into the tracepoint on not
> just what is available to the trace event:
>
>   https://lore.kernel.org/all/20220312232551.181178712@goodmis.org/

Thanks for the info.  But it's unclear to me if it provides the custom
event with the same or different name.  Can I use both of the original
and the custom events at the same time?

Thanks,
Namhyung

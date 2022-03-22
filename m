Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D7C4E387D
	for <lists+linux-arch@lfdr.de>; Tue, 22 Mar 2022 06:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236699AbiCVFdM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 22 Mar 2022 01:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236687AbiCVFdK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 22 Mar 2022 01:33:10 -0400
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 213E3249;
        Mon, 21 Mar 2022 22:31:43 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w27so27953571lfa.5;
        Mon, 21 Mar 2022 22:31:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GlCF52bxxY28UlNxgmhgKK45ax8F8swF4A2rg+FXHy8=;
        b=RTaAKWo2+U2GnEQlQJf5I5moVxU4y9BOa5eaX65dOBsMnUJpu8Yjr8K41+78iIcJ04
         bHnCA+VpN24eujFeTklrIggWU3uFJqNLCA89kV+Lg9eshHSULaVV4ZJHZXkWJR0S0QzJ
         oixVt6z52Eb8vRc17DQrqzXXndM4A5DTPZcxPeDs5fKC05uwe/6qnWJ7ZNUw3Nw+YjvG
         kT+6awL8PujnDVsncATMokYi6GfGuUatZoHohGppTtJgBFDWg1JsaVVYbNNiVSNOS7xC
         98bEVr0uNVdw1bdH7t1Dk7ZgkSGM+tV9qBYX6gxnX01B2Cmo/qohU+A4QjqgAGwfI2b5
         zQ2g==
X-Gm-Message-State: AOAM531EoY+0EF3kAj5bGc5o3s9PQgRuK6csdHfTx1i/wDsEMODn481w
        Ki1mlv+cyEAksRhtI7XY4s7x8407hkdpGe+Rz3jcXGxi
X-Google-Smtp-Source: ABdhPJycvwEtuIvjB/LhUB1Fhx0OATgyKkPDKpsT/6QpvwiTD5yXpNCEX+sM1OnqWBdmgIYRJpnkyD6PJUwDav6DY7I=
X-Received: by 2002:a05:6512:32c6:b0:448:53c6:7023 with SMTP id
 f6-20020a05651232c600b0044853c67023mr17142824lfg.481.1647927101041; Mon, 21
 Mar 2022 22:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-3-namhyung@kernel.org>
 <YjSBRNxzaE9c+F/1@boqun-archlinux> <YjS2rlezTh9gdlDh@hirez.programming.kicks-ass.net>
 <CAM9d7cjUR6shddKM2h9uFXgQf+0F504fnJmKRSfc3+PG3TmEyg@mail.gmail.com>
 <20220318180750.744f08d4@gandalf.local.home> <CAM9d7ci-91efxreUvLBhkAcs0rpngzR9+3BnZBDb4zLai2Ewcw@mail.gmail.com>
In-Reply-To: <CAM9d7ci-91efxreUvLBhkAcs0rpngzR9+3BnZBDb4zLai2Ewcw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 21 Mar 2022 22:31:30 -0700
Message-ID: <CAM9d7cgCEsH6grH556Js6VX-cXAO_3hT7C+RSm+sxxBDgxHvig@mail.gmail.com>
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

On Fri, Mar 18, 2022 at 5:11 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> On Fri, Mar 18, 2022 at 3:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Fri, 18 Mar 2022 14:55:27 -0700
> > Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > > > > This looks a littl ugly ;-/ Maybe we can rename __down_common() to
> > > > > ___down_common() and implement __down_common() as:
> > > > >
> > > > >       static inline int __sched __down_common(...)
> > > > >       {
> > > > >               int ret;
> > > > >               trace_contention_begin(sem, 0);
> > > > >               ret = ___down_common(...);
> > > > >               trace_contention_end(sem, ret);
> > > > >               return ret;
> > > > >       }
> > > > >
> > > > > Thoughts?
> > > >
> > > > Yeah, that works, except I think he wants a few extra
> > > > __set_current_state()'s like so:
> > >
> > > Not anymore, I decided not to because of noise in the task state.
> > >
> > > Also I'm considering two tracepoints for the return path to reduce
> > > the buffer size as Mathieu suggested.  Normally it'd return with 0
> > > so we can ignore it in the contention_end.  For non-zero cases,
> > > we can add a new tracepoint to save the return value.
> >
> > I don't think you need two tracepoints, but one that you can override.
> >
> > We have eprobes that let you create a trace event on top of a current trace
> > event that can limit or extend what is traced in the buffer.
> >
> > And I also have custom events that can be placed on top of any existing
> > tracepoint that has full access to what is sent into the tracepoint on not
> > just what is available to the trace event:
> >
> >   https://lore.kernel.org/all/20220312232551.181178712@goodmis.org/
>
> Thanks for the info.  But it's unclear to me if it provides the custom
> event with the same or different name.  Can I use both of the original
> and the custom events at the same time?

I've read the code and understood that it's a separate event that can
be used together.  Then I think we can leave the tracepoint with the
return value and let users customize it for their needs later.

Thanks,
Namhyung

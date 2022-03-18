Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF64DE30F
	for <lists+linux-arch@lfdr.de>; Fri, 18 Mar 2022 21:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbiCRU74 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Mar 2022 16:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237010AbiCRU7y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 18 Mar 2022 16:59:54 -0400
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692107EB19;
        Fri, 18 Mar 2022 13:58:35 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id p15so5185973lfk.8;
        Fri, 18 Mar 2022 13:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZpUmnv5nnCuerIF7dNzjzviRvOSuKnz8K3jWowIdqs=;
        b=c90c+Pd+UrrZcjk+b9FTklSYMbXSJbiGqfqXoQMqUhtNKbRJa5j2griTt74ionRKPf
         0Ok2ToT/ihxwFuj9UsoSgo6gXXgTQR553auH+2EZJximyzPKKN4iZrB+89vfw5li2KgN
         2WuJWqVbxnsg7iV5+j1bTbtl39i7hso5Xr40qKlP2ofT4Z/ZJRojGNhR8HKgbAj5OgqJ
         AHI39hm9FNYckmavgaS40QW6qE+1+5J0Txb2OLSU33K2+V3dJMFS9tt7soyWKhygAF2j
         bD+RThKwzZgzLoIX8J/ES+zvO5+Sr+kG2jRNPF1TTiKYu4CqLWSSFYZpcC7mdJx1QqSg
         ozgw==
X-Gm-Message-State: AOAM531wP2bvURoBcMS2zciPLhMe4Cbgd9TD9tv/oj5ip2SS1lMS6fOW
        LMByqmlqbamidKExs9l4QReivFzVERQzsupwTKw=
X-Google-Smtp-Source: ABdhPJwoznZL5xlVNeXYbcK4SKeRSHWd60J2ZCeqZmXj8bdxiTTr8C7LJLZPR7iQXYZEJMuVERuKSgO2a6Qf6ceXzOU=
X-Received: by 2002:ac2:4e04:0:b0:449:f68e:c7d1 with SMTP id
 e4-20020ac24e04000000b00449f68ec7d1mr5801959lfr.586.1647637113538; Fri, 18
 Mar 2022 13:58:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220316224548.500123-1-namhyung@kernel.org> <20220316224548.500123-2-namhyung@kernel.org>
 <636955156.156341.1647523975127.JavaMail.zimbra@efficios.com>
 <20220317120753.4cd73f9e@gandalf.local.home> <1649265824.157580.1647535061743.JavaMail.zimbra@efficios.com>
In-Reply-To: <1649265824.157580.1647535061743.JavaMail.zimbra@efficios.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Fri, 18 Mar 2022 13:58:22 -0700
Message-ID: <CAM9d7chSR7DtUsVtKUDp94kCFtTgL4tWqvck1qSqwWMX8ov8Eg@mail.gmail.com>
Subject: Re: [PATCH 1/2] locking: Add lock contention tracepoints
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        paulmck <paulmck@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
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

Hi Mathieu and Steve,

On Thu, Mar 17, 2022 at 9:37 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Mar 17, 2022, at 12:07 PM, rostedt rostedt@goodmis.org wrote:
>
> > On Thu, 17 Mar 2022 09:32:55 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> >> Unless there is a particular reason for using preprocessor defines here, the
> >> following form is typically better because it does not pollute the preprocessor
> >> defines, e.g.:
> >>
> >> enum lock_contention_flags {
> >>         LCB_F_SPIN =   1U << 0;
> >>         LCB_F_READ =   1U << 1;
> >>         LCB_F_WRITE =  1U << 2;
> >>         LCB_F_RT =     1U << 3;
> >>         LCB_F_PERCPU = 1U << 4;
> >> };
> >
> > If you do this, then to use the __print_flags(), You'll also need to add:
> >
> > TRACE_DEFINE_ENUM(LCB_F_SPIN);
> > TRACE_DEFINE_ENUM(LCB_F_READ);
> > TRACE_DEFINE_ENUM(LCB_F_WRITE);
> > TRACE_DEFINE_ENUM(LCB_F_RT);
> > TRACE_DEFINE_ENUM(LCB_F_PERCPU);
> >
> > Which does slow down boot up slightly.
>
> So it looks like there is (currently) a good reason for going with the #define.

Thanks for your suggestions, I'd go with define this time and we could
convert it to enum later (hopefully after the boot time is resolved).

Thanks,
Namhyung

>
> As a side-discussion, I keep finding it odd that this adds overhead on boot. I suspect
> this is also implemented as a linked list which needs to be iterated over at boot-time.
>
> With a few changes to these macros, these linked lists could be turned into arrays,
> and thus remove the boot-time overhead.

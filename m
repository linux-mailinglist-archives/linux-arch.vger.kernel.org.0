Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0764ECCDF
	for <lists+linux-arch@lfdr.de>; Wed, 30 Mar 2022 21:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348979AbiC3TFH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 30 Mar 2022 15:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343685AbiC3TFG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 30 Mar 2022 15:05:06 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD25E91566;
        Wed, 30 Mar 2022 12:03:20 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id r22so29004033ljd.4;
        Wed, 30 Mar 2022 12:03:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/XO48kbTH6x+OL0Vadnhd908y5V+Gn64iUZTtds2fg=;
        b=PVV93CIDcNWAaE6F7gIbHZvBu8eBGCQTktH45kw5XDxR+2BE3NExTOlravDStQba0f
         J7H4UHKnsdYEMQOlfwLCDW88guGODiuPGDyt+cdOuipdW6MAxgnSZ28yIkI1eVPrJS/I
         oamqw2aFNI/aZdyRFezsBQW3CEKzSyfMGE9rlGrjS3IR/Y5+B+ZSk/B6zCF5ar1A1Luw
         Xp90cyig8DPRHus67+65mn7/1f7XY16QvfWB0HKzq9cH+2GwHhUUABbZw3wQsB/drBd0
         zdtl6YjLEwzM56NDzZVV/j5X9njRjkV1H4JxpIhs4ZA/to8/exrzGsYfae381JhsPKmg
         i9zQ==
X-Gm-Message-State: AOAM532EupbYY28eKgLZVMjbWrMgsvWMnGfD9UUpdHJg9XLPThpopO59
        jXeY3vGqBjy1VG4v78l3PHaNSmIhRlLODQweFeY=
X-Google-Smtp-Source: ABdhPJy+CWJtC2kcMo7bIJcJGew6k36kdv506JaCAeyzEKOlEcz0Ts7wQoKUvF9nbQLUsbpND7PC+z7yBPsDPa2v1v8=
X-Received: by 2002:a2e:82c5:0:b0:247:e81f:8b02 with SMTP id
 n5-20020a2e82c5000000b00247e81f8b02mr7801845ljh.90.1648666997681; Wed, 30 Mar
 2022 12:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220322185709.141236-1-namhyung@kernel.org> <20220322185709.141236-3-namhyung@kernel.org>
 <20220328113946.GA8939@worktop.programming.kicks-ass.net> <CAM9d7ciQQEypvv2a2zQLHNc7p3NNxF59kASxHoFMCqiQicKwBA@mail.gmail.com>
 <20220330110853.GK8939@worktop.programming.kicks-ass.net>
In-Reply-To: <20220330110853.GK8939@worktop.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 30 Mar 2022 12:03:06 -0700
Message-ID: <CAM9d7cjQnThKgsUfnqJDcmBFseSTk-56a6f0sefo1x8D7LWSZw@mail.gmail.com>
Subject: Re: [PATCH 2/2] locking: Apply contention tracepoints in the slow path
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
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
        bpf <bpf@vger.kernel.org>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
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

On Wed, Mar 30, 2022 at 4:09 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 28, 2022 at 10:48:59AM -0700, Namhyung Kim wrote:
> > > Also, if you were to add LCB_F_MUTEX then you could have something like:
> >
> > Yep, I'm ok with having the mutex flag.  Do you want me to send
> > v5 with this change or would you like to do it by yourself?
>
> I'll frob my thing on top. No need to repost.

Cool, thanks for doing this!

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845994F13F6
	for <lists+linux-arch@lfdr.de>; Mon,  4 Apr 2022 13:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346463AbiDDLqF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Apr 2022 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348762AbiDDLqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Apr 2022 07:46:04 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B9CB1B7A7;
        Mon,  4 Apr 2022 04:44:08 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id cs16so1456035qvb.8;
        Mon, 04 Apr 2022 04:44:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYvQ/9sOxTrqd5FO05k5YTA5C/LjNCLjagWPfQG2994=;
        b=TBjThrjyTVGV54MpL6ZIexcyW0rJu6yhTulv5b07N1fqiwyVK4VfBz8lIB1/nwLR+m
         zvsbVMjV88OurfMyzYhQpmLw44taIJYnnZI9mAf7t4fno50TQAXD5grCHNSJE2eyZE2N
         oAwOmgIGYwG1c1OZzWJ2d7BLjQoBhla4/XO8/0Y6FSfPhe2P7x0CTXxmYTv8xp8cKomQ
         ePmQeKr37Ks5CZmW7nAustErX5QbB51D0nx7cbcBmN9SlqBdI9g+/G7KHEiNPJPQsvEn
         /kZy46eQ9JMH5B5x1/zezm8lUCt8yvhol/ZxoQF7RJvNLGqmqwhD/AbDpKIvpoItuP7v
         m4ww==
X-Gm-Message-State: AOAM532HMyNGTYI+vJNPRtQdsUkbBwt8AzfqTydAMjhQvoYEMDS59aiM
        7LOX1SShTI/v7GZAQrts/BTSdHCZuqoxfA==
X-Google-Smtp-Source: ABdhPJwdMakYhtdX8SLs2XnS0r8JzMTRUuj7J4cA8fynCYCjUd89wsDtWFurjirFgAHi4fKX92+/EQ==
X-Received: by 2002:a05:6214:c44:b0:443:c09c:b15c with SMTP id r4-20020a0562140c4400b00443c09cb15cmr7518017qvj.30.1649072646773;
        Mon, 04 Apr 2022 04:44:06 -0700 (PDT)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id e20-20020ac84e54000000b002e06753cf70sm9416199qtw.6.2022.04.04.04.44.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Apr 2022 04:44:06 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2e5e9025c20so95510687b3.7;
        Mon, 04 Apr 2022 04:44:05 -0700 (PDT)
X-Received: by 2002:a81:618b:0:b0:2db:d952:8a39 with SMTP id
 v133-20020a81618b000000b002dbd9528a39mr22035506ywb.132.1649072645615; Mon, 04
 Apr 2022 04:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220404111204.935357-1-elver@google.com>
In-Reply-To: <20220404111204.935357-1-elver@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 4 Apr 2022 13:43:54 +0200
X-Gmail-Original-Message-ID: <CAMuHMdURqaCYDt5SJg0GLKqEs92JgUhHAhVa8B4RKextRH43aQ@mail.gmail.com>
Message-ID: <CAMuHMdURqaCYDt5SJg0GLKqEs92JgUhHAhVa8B4RKextRH43aQ@mail.gmail.com>
Subject: Re: [PATCH] signal: Deliver SIGTRAP on perf event asynchronously if blocked
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
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

On Mon, Apr 4, 2022 at 1:30 PM Marco Elver <elver@google.com> wrote:
> With SIGTRAP on perf events, we have encountered termination of
> processes due to user space attempting to block delivery of SIGTRAP.
> Consider this case:
>
>     <set up SIGTRAP on a perf event>
>     ...
>     sigset_t s;
>     sigemptyset(&s);
>     sigaddset(&s, SIGTRAP | <and others>);
>     sigprocmask(SIG_BLOCK, &s, ...);
>     ...
>     <perf event triggers>
>
> When the perf event triggers, while SIGTRAP is blocked, force_sig_perf()
> will force the signal, but revert back to the default handler, thus
> terminating the task.
>
> This makes sense for error conditions, but not so much for explicitly
> requested monitoring. However, the expectation is still that signals
> generated by perf events are synchronous, which will no longer be the
> case if the signal is blocked and delivered later.
>
> To give user space the ability to clearly distinguish synchronous from
> asynchronous signals, introduce siginfo_t::si_perf_flags and
> TRAP_PERF_FLAG_ASYNC (opted for flags in case more binary information is
> required in future).
>
> The resolution to the problem is then to (a) no longer force the signal
> (avoiding the terminations), but (b) tell user space via si_perf_flags
> if the signal was synchronous or not, so that such signals can be
> handled differently (e.g. let user space decide to ignore or consider
> the data imprecise).
>
> The alternative of making the kernel ignore SIGTRAP on perf events if
> the signal is blocked may work for some usecases, but likely causes
> issues in others that then have to revert back to interception of
> sigprocmask() (which we want to avoid). [ A concrete example: when using
> breakpoint perf events to track data-flow, in a region of code where
> signals are blocked, data-flow can no longer be tracked accurately.
> When a relevant asynchronous signal is received after unblocking the
> signal, the data-flow tracking logic needs to know its state is
> imprecise. ]
>
> Link: https://lore.kernel.org/all/Yjmn%2FkVblV3TdoAq@elver.google.com/
> Fixes: 97ba62b27867 ("perf: Add support for SIGTRAP on perf events")
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Marco Elver <elver@google.com>

>  arch/m68k/kernel/signal.c          |  1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

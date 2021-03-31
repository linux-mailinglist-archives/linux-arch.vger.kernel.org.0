Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67747350068
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235289AbhCaMdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 08:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhCaMdL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 31 Mar 2021 08:33:11 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C941FC06175F
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 05:33:10 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id g8-20020a9d6c480000b02901b65ca2432cso18763364otq.3
        for <linux-arch@vger.kernel.org>; Wed, 31 Mar 2021 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G2AUmQQuU10DnwHLe3j88zasAy4fwJf13uqVDHeKF6c=;
        b=dMoq/sx5t1QGdWz5mTYVbtcbABRgM77PzP4Pt01l7AzVneg2FZGmwBCFUhIPg13pZ0
         R619RV7rjyIwhw5y6lVdlrOdBwndHm4XiOVOHkGdmfWiebKt0dk4gJkSv+ZqujYccdk1
         /Y9YUnUSj7EaYfCx4xSDb8WZXyAwY2BQYjCLWh/2BQ7A8YdPpd0RTCwD0ajhFfvFREy6
         8KaYkaqq+Obvx6/ePJpZLkWM8F7nHI2VRFTELT4G7dijwVkjF7wjpCvxPW6gxRuAnniL
         UURsS9hiUCAws+mhBJ1hPy3MFGmAiuLzrd7NwoGC1DlVfrl/kvwiEwz4DVaEIK/NAQyY
         B5lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G2AUmQQuU10DnwHLe3j88zasAy4fwJf13uqVDHeKF6c=;
        b=ubzo5TCttkodOgQ6llsI2dFuoY0PzfioBgXrYKCFCAlq8Pmk3eSNXw/L/vKNM3Oph/
         ZzJp1Axps/8L02o9EarxCP6RDIfRfNuvDBi2yKmPrTIfs9HQyAO3rxbkErZTYDfzVCXV
         3ZtrIF0hapCyIWgO4OJfEbvqPatW2i366EyaR+49hnvukqeX4ti+9MIg7Qhl0nk+7yNu
         9Say3aWX77etInJFSDYovHjw0cY1mOe4vpwZLDlKGbVNU+EDUKlVWzWsUXTLtOcCHoAC
         1gcOzoJH6Xsla5SkFFDRf9RlGZQjuqJDZdFiWgZMnEqAaonEnny8bjqPrsma0CnHfHfH
         +TVQ==
X-Gm-Message-State: AOAM531srfZg07eYl97oBiGLz9EamThv1MVXzJB4QzvlKMf5U7lZpMIi
        ZcWWGC2N7BtAeNOBcb8uwk5UBWPNOYaYUvz3WgxHCg==
X-Google-Smtp-Source: ABdhPJx6YDqVXlG9dIvGvuotdIeqBs0jLh1oYI6fps8tuotAwF3xJLdVe9L4RGLJ/HPVeJgnUb4aEQgH994pcSTpmPk=
X-Received: by 2002:a9d:5508:: with SMTP id l8mr2553279oth.233.1617193990006;
 Wed, 31 Mar 2021 05:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210324112503.623833-1-elver@google.com> <20210324112503.623833-7-elver@google.com>
 <YFxGb+QHEumZB6G8@elver.google.com> <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
In-Reply-To: <YGHC7V3bbCxhRWTK@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Wed, 31 Mar 2021 14:32:58 +0200
Message-ID: <CANpmjNOPJNhJ2L7cxrvf__tCZpy=+T1nBotKmzr2xMJypd-oJQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] perf: Add support for SIGTRAP on perf events
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian@brauner.io>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
        Matt Morehouse <mascasa@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Ian Rogers <irogers@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 29 Mar 2021 at 14:07, Peter Zijlstra <peterz@infradead.org> wrote:

> (and we might already have a problem on some architectures where there
> can be significant time between these due to not having
> arch_irq_work_raise(), so ideally we ought to double check current in
> your case)

I missed this bit -- just to verify: here we want to check that
event->ctx->task == current, in case the the irq_work runs when the
current task has already been replaced. Correct?

Thanks,
-- Marco

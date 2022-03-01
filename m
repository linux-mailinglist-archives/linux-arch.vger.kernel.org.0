Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58C24C92FB
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 19:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234261AbiCAS0j (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 13:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiCAS0i (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 13:26:38 -0500
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377C6515F;
        Tue,  1 Mar 2022 10:25:56 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id v28so22984767ljv.9;
        Tue, 01 Mar 2022 10:25:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s6DUiFskOYbQ+Ck/lkK1O7UIc++6NtzCSpAL7foCAE4=;
        b=SDv7X3qt6ybmSVewm7n/0RtrbUEzeF7dyQUSa17W2PJBCEmGdcgx2ljOJHF34QStqk
         KkNnLCbl0Q6QsohgMQzEhfsJuu9ox414/P9tVbTSR1Eg5e9FxbQhv/7wBc5wwqEyCpWD
         13/2PzvTsU7L85NX29DrQVRGiiM9J5VhPxDjDmukQYySfdwynp6STw8RrAgSwdhSDBtc
         MQj7BHB5+nFgHo6Txrz1VyMLJ4UbHN6ksTlyebIN1Os+AeKTVRGcb+hkQgIUfoOAGvIv
         yx2qhQ2EUarpyUZX1S2NvXJbSe2hFIaxVsfFLbOeQ1OBg67WVEqmA97Q/NyHo8gHR3Uq
         KgIg==
X-Gm-Message-State: AOAM532lJ7uYcOiR84I10snrI+6ktMa2CjH0Jq0f7i/mdja6N4ZQfLeG
        6Rop7YgPxcfaeqhbNUMADPHIyj57Lt3S0khTV2Q=
X-Google-Smtp-Source: ABdhPJyZU9iweug4accW/5RqwICgEq7TDb7Oq+GIai7exNilWqkOUuniSKsc3XQFAMYeYyKFfMFd0LqcEw1skYuKsxI=
X-Received: by 2002:a2e:891a:0:b0:246:293f:875e with SMTP id
 d26-20020a2e891a000000b00246293f875emr17268761lji.204.1646159154549; Tue, 01
 Mar 2022 10:25:54 -0800 (PST)
MIME-Version: 1.0
References: <20220301010412.431299-1-namhyung@kernel.org> <20220301010412.431299-4-namhyung@kernel.org>
 <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh3hyIIHLJEXZND3@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Mar 2022 10:25:43 -0800
Message-ID: <CAM9d7chsdfvNAX1hd3p+Jd6MvEBJd3xbe-JpE2MOBWv-vXF9DA@mail.gmail.com>
Subject: Re: [PATCH 3/4] locking/mutex: Pass proper call-site ip
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

On Tue, Mar 1, 2022 at 1:05 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 28, 2022 at 05:04:11PM -0800, Namhyung Kim wrote:
> > The __mutex_lock_slowpath() and friends are declared as noinline and
> > _RET_IP_ returns its caller as mutex_lock which is not meaningful.
> > Pass the ip from mutex_lock() to have actual caller info in the trace.
>
> Blergh, can't you do a very limited unwind when you do the tracing
> instead? 3 or 4 levels should be plenty fast and sufficient.

Are you talking about getting rid of the ip from the tracepoints?
Having stacktraces together is good, but it'd be nice if it provided
a way to identify the lock without them too.

Thanks,
Namhyung

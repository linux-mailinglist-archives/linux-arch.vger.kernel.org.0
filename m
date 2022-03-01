Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F044C9286
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 19:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbiCASEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Mar 2022 13:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCASEx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Mar 2022 13:04:53 -0500
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8F205C4;
        Tue,  1 Mar 2022 10:04:10 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id v22so22947708ljh.7;
        Tue, 01 Mar 2022 10:04:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e5d4xKeEeUZ3+qWANyOhEjefcxDPbVrweTplbTrGL0=;
        b=XbEol5Idr3Jxdf0oIwFNehiDpMcJvxAGlN7NjXT0vPdtPXflh6W9lIAKvtoS4I3hGM
         yWFYsUt80IDHhvnkbNn2ZYRdgZp2KUVUIZru832OHfpsyX+b2896Mf6Ny4cM/tIuMk7E
         CTHbD/vg3Cpa61lx47WLD/NgH+37SMq2hCTXgwuKiTk33vOa/f5p0p7xpXimbuPPZtpV
         zMmziONZ9eguPTrJe0+uZ5IyTX/umq0gOjgCVm4thjiqONTB80IWMSws7gpoTxk5jRKt
         KR4jYs12jE1aC4W8ZwPb9sGTIPFf5c4Tyfs955nScnpAGMMVPQ12v8BKp1O3AW5+zH+M
         Mk7Q==
X-Gm-Message-State: AOAM5328jZ/YUFO90iMae1glVZy2wFnWHL/2HS5rtwi97QRMEUYYCbnK
        0oSpQ9aR/KjCnqsSM7Ar3UmqRxB0WhDF8Toyeeo=
X-Google-Smtp-Source: ABdhPJynEtWmU+r7YVpV/44yaa1XMqFio7eeol8Jvu88b1N6K5fmbNWznf5U9Eepkwm+AIwaL+W1fa4QAVUjN49JMsI=
X-Received: by 2002:a2e:819a:0:b0:240:8b4c:ef10 with SMTP id
 e26-20020a2e819a000000b002408b4cef10mr18068820ljg.180.1646157848769; Tue, 01
 Mar 2022 10:04:08 -0800 (PST)
MIME-Version: 1.0
References: <20220301010412.431299-1-namhyung@kernel.org> <20220301010412.431299-3-namhyung@kernel.org>
 <Yh3cwBloddIGvCjU@hirez.programming.kicks-ass.net>
In-Reply-To: <Yh3cwBloddIGvCjU@hirez.programming.kicks-ass.net>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 1 Mar 2022 10:03:57 -0800
Message-ID: <CAM9d7cguuyY74L9XK=z384bwO6nTCw4XOFNK1yaJhhmKYTBBoA@mail.gmail.com>
Subject: Re: [PATCH 2/4] locking: Apply contention tracepoints in the slow path
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

Hi Peter,

On Tue, Mar 1, 2022 at 12:44 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Feb 28, 2022 at 05:04:10PM -0800, Namhyung Kim wrote:
> > @@ -80,7 +81,9 @@ static inline void queued_read_lock(struct qrwlock *lock)
> >               return;
> >
> >       /* The slowpath will decrement the reader count, if necessary. */
> > +     LOCK_CONTENTION_BEGIN(lock, LCB_F_READ);
> >       queued_read_lock_slowpath(lock);
> > +     LOCK_CONTENTION_END(lock);
> >  }
> >
> >  /**
> > @@ -94,7 +97,9 @@ static inline void queued_write_lock(struct qrwlock *lock)
> >       if (likely(atomic_try_cmpxchg_acquire(&lock->cnts, &cnts, _QW_LOCKED)))
> >               return;
> >
> > +     LOCK_CONTENTION_BEGIN(lock, LCB_F_WRITE);
> >       queued_write_lock_slowpath(lock);
> > +     LOCK_CONTENTION_END(lock);
> >  }
>
> > @@ -82,7 +83,9 @@ static __always_inline void queued_spin_lock(struct qspinlock *lock)
> >       if (likely(atomic_try_cmpxchg_acquire(&lock->val, &val, _Q_LOCKED_VAL)))
> >               return;
> >
> > +     LOCK_CONTENTION_BEGIN(lock, 0);
> >       queued_spin_lock_slowpath(lock, val);
> > +     LOCK_CONTENTION_END(lock);
> >  }
>
> Can you please stick that _inside_ the slowpath? You really don't want
> to inline that.

I can move it into the slow path with caller ip.

Thanks,
Namhyung

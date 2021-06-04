Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5BB839BD50
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 18:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbhFDQhe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 12:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhFDQhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 12:37:33 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEC9C061766
        for <linux-arch@vger.kernel.org>; Fri,  4 Jun 2021 09:35:47 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id b11so11871243edy.4
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 09:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+KCY22dx//O8yKBxj7GElgNdKz9QEJ9C/z48QZLkP0=;
        b=Q0SDTPiRYq2yIU2qzA4zQezJqPCyIpRgdDRy5hzw0WsIyYEkLWCl62youFoH0X2uC0
         eVaISP8lDacL3mGgoXK3K6Ag2+p4ihUDx2/neQu9mt91HNI1IG6z88lysj5wO8G/RtxP
         Lslm9wLgxNXrM2ODEsKLK+rKm2h7dfub/WPgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+KCY22dx//O8yKBxj7GElgNdKz9QEJ9C/z48QZLkP0=;
        b=Ed8S5g3vvfIWLT1ZTp/5yN5kRQPCcWh1svauTN2wUMMTitx5rKcttNEDhebxw9yxtO
         lTFL4FMvfsqchu+DRZE8xtIrrPjyEMYRbDartjd/3nVbeFa5b0Ddv7x211tIug33Nzgl
         ORyajQCboBItQtyDtA7P3xsczZ53nHeKxd7Q8tmMxjrJSwHg7TX5rOsYazHbNzHT4SQ2
         dD6KhTR4c1BsvSlwE8YhP54VxPJNZLED/xnXzY6q/wzxcy/JoDerWou24d8qpj42LVA4
         vgVsqYQ63pbH+9sqZ5zoQWVH14mzliUZjAEvKsCMsf7dA9zD0DvHEz+Kd9GtWnvfQzFM
         DMgg==
X-Gm-Message-State: AOAM5321d+1fH2JQW5yYYAjmJcyj2O+INfkwzwJDL7M0WB8A3modj8Jk
        dwOpyGS/dDDhU+kGmD0LVjNOIofRCr2Otk2IDs0=
X-Google-Smtp-Source: ABdhPJxZivoPVdfGrdsLOz+ShJ9658z1v+2U2vzitseKmg/5J4wd3pFO/WLe2mkCYb0vi+udDSJ+Uw==
X-Received: by 2002:a05:6402:204:: with SMTP id t4mr5512447edv.34.1622824545804;
        Fri, 04 Jun 2021 09:35:45 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id md23sm2973985ejb.110.2021.06.04.09.35.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 09:35:45 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id f5so6851602eds.0
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 09:35:45 -0700 (PDT)
X-Received: by 2002:ac2:43b9:: with SMTP id t25mr3311306lfl.253.1622824217183;
 Fri, 04 Jun 2021 09:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
In-Reply-To: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 09:30:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
Message-ID: <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 4, 2021 at 3:12 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> I've converted most architectures we care about, and the rest will get
> an extra smp_mb() by means of the 'generic' fallback implementation (for
> now).

Why is "volatile_if()" not just

       #define barier_true() ({ barrier(); 1; })

       #define volatile_if(x) if ((x) && barrier_true())

because that should essentially cause the same thing - the compiler
should be *forced* to create one conditional branch (because "barrier"
is an asm that can't be done on the false side, so it can't do it with
arithmetic or other games), and after that we're done.

No need for per-architecture "asm goto" games. No new memory barriers.
No actual new code generation (except for the empty asm volatile that
is a barrier).

              Linus

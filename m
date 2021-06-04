Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D7C39BEF6
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 19:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbhFDRkt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 13:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbhFDRkt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 13:40:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF02C061766
        for <linux-arch@vger.kernel.org>; Fri,  4 Jun 2021 10:39:02 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a1so5588299lfr.12
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 10:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9fPMUfjUiK0FrRER6EH6PeTXMziUWqxljccly8zx7c=;
        b=MJ0NfISVyYy/x/kclYN0s9fJRn5RliOT0U+w0BfCWBnLtWRtfPyvQRs2IIykEPgYRA
         iPmdQbb2zzRdZQzIE2X5p3HF4kbmJgxzs1DJCeD2N6RMTL7zDRAxmbT8zPfNnpdiIRZD
         KX2qRRFcTYEo6EAz4KL2o5iAZ1t2awg7AqCwY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9fPMUfjUiK0FrRER6EH6PeTXMziUWqxljccly8zx7c=;
        b=jS0YfUazdDsVpol1MxPzfTB7hSE5nfJJkPyhezJTo9J8C0dI6rqsopyw4vJ63hGna4
         rzh2KMgDyqpe5UQo5opJCUm/vud0IdaGpkcDAI8w2Kd6tpwWRRa1cQX6AYp/T8wLHIYB
         7tjVPn4UMmIcz+cNan17EAY6Qt3mPJu9MkeL515svHh6uyIrlJYIhHpsWNNiwx9alxNf
         tSvS83sSlscRS8FKrbtdQU0+/EqQ32/yY7D/9OvYpf6D6w4ZTbBMVF+mtWObbwgIn6YM
         e+JUPFR9ZwJGwsxW3QSsKb9FZH0XJU5nj8+4F41m6HM+Yk5yeDjk5GAeBTne6GbUqJtL
         vG8A==
X-Gm-Message-State: AOAM532ctHdDmK+e+fpRApHrgguTnuzW7wH2NYZJ1mA7U1V7evRCZ5m6
        1bvKFonO01EHF7SExMqkxzGvDtttUzDMo6DX
X-Google-Smtp-Source: ABdhPJyBiFl3SslHVjn+B3zhc/+y9eTetGWkMWH6gwz0Xk3yyYC/8h8p+eRwLJf1GFossDqs/o1quQ==
X-Received: by 2002:a05:6512:3da8:: with SMTP id k40mr3497419lfv.450.1622828340654;
        Fri, 04 Jun 2021 10:39:00 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id a1sm665920lff.215.2021.06.04.10.38.59
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:39:00 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id f11so15212669lfq.4
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 10:38:59 -0700 (PDT)
X-Received: by 2002:a05:6512:baa:: with SMTP id b42mr3435945lfv.487.1622828339731;
 Fri, 04 Jun 2021 10:38:59 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com>
 <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net> <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
 <20210604172407.GJ18427@gate.crashing.org>
In-Reply-To: <20210604172407.GJ18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 10:38:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj0Qvpn0pOOhJMGOim=psP3bhS2dEX1bAvQpmXs__vqiQ@mail.gmail.com>
Message-ID: <CAHk-=wj0Qvpn0pOOhJMGOim=psP3bhS2dEX1bAvQpmXs__vqiQ@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
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

On Fri, Jun 4, 2021 at 10:27 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> > Of course, we might want to make sure that the compiler doesn't go
> > "oh, empty asm, I can ignore it",
>
> It isn't allowed to do that.  GCC has this arguable misfeature where it
> doesn't show empty asm in the assembler output, but that has no bearing
> on anything but how human-readable the output is.

That sounds about right, but we have had people talking about the
compiler looking inside the asm string before.

So it worries me that some compiler person might at some point go all
breathy-voice on us and say "I am altering the deal. Pray I don't
alter it any further".

Side note: when grepping for what "barrier()" does on different
architectures and different compilers, I note that yes, it really is
just an empty asm volatile with a "memory" barrier. That should in all
way sbe sufficient.

BUT.

There's this really odd comment in <linux/compiler-intel.h> that talks
about some "ECC" compiler:

  /* Intel ECC compiler doesn't support gcc specific asm stmts.
   * It uses intrinsics to do the equivalent things.
   */

and it defines it as "__memory_barrier()". This seems to be an ia64 thing, but:

 - I cannot get google to find me any documentation on such an intrinsic

 - it seems to be bogus anyway, since we have "asm volatile" usage in
at least arch/ia64/mm/tlb.c

So I do note that "barrier()" has an odd definition in one odd ia64
case, and I can't find the semantics for it.

Admittedly I also cannot find it in myself to care. I don't think that
"Intel ECC" compiler case actually exists, and even if it does I don't
think itanium is relevant any more. But it was an odd detail on what
"barrier()" actually might mean to the compiler.

              Linus

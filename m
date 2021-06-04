Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85C039C03C
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230118AbhFDTMu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 15:12:50 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:35430 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhFDTMt (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 15:12:49 -0400
Received: by mail-lf1-f42.google.com with SMTP id i10so15639920lfj.2
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 12:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T0rhuF38mqlddZeGtqw9HWeoOpr9kTyYXC76PTtvZTI=;
        b=bqz/v8bxM6Y2C4y6pQ7PsKvyteq3TnBiodzjWhScm//3Wc17NomPn4/wOmKzgw9sS5
         aw476sma+5s+vRwXpiAavsJe205Vio7NCA6OUYe6v+C0gkSB7Kh0LGQJ9VYPvijml7Xs
         fjpjl09RafGIaEivo8nZzNIikq7Zf4QhWZ+NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0rhuF38mqlddZeGtqw9HWeoOpr9kTyYXC76PTtvZTI=;
        b=IkIvKMy0c/ywxCsYcJZyt4kQ29fs9XUHUO2a1x4wjljtci4CLQDqMRttOKFPJcfKR0
         a/n/TJzKXVmLZjKlChiWhlKa8g/g+7A0xlZDB8yGszMPrlfFEpfSVNjbQCsJlQr+YUyc
         /KKI2vB0Xlp5VXmNjc2ILUGamaoVvP034BQ1+Oa96LdxPH5/1jw8toqEKv20w4Q2UjcE
         IKdRjcKUP/LxzGe1Wn0uM1J23s8t687NIJfBtKme+KA5HX9QAiYYvW5cSIrBvA4JIG5B
         UFvIVIVilpS6tyE4kgyMMe8NboxZqrscvpK5kPYmM8ymlJn7N351XHiZ8B7KTwHwgQST
         TeTQ==
X-Gm-Message-State: AOAM530PXM8xKsv8BbgbXhFi/T7hrNnYZT1ylsv+8GHVHYspsoWBUxrI
        HSMYaMZ0ucWfq8Q5EbruYnO8ye59Fpzc4sfzkyc=
X-Google-Smtp-Source: ABdhPJxEWAAefrGC2t1E6k2ely9zE4LNbZyL2BzxfQZKkfAuDz6QuY0HaPRMXH4FsU/aBuW2EafQNg==
X-Received: by 2002:a05:6512:2206:: with SMTP id h6mr3932670lfu.345.1622833785860;
        Fri, 04 Jun 2021 12:09:45 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id a25sm686731lfl.38.2021.06.04.12.09.44
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:09:44 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id w15so12846915ljo.10
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 12:09:44 -0700 (PDT)
X-Received: by 2002:a2e:9644:: with SMTP id z4mr4536606ljh.507.1622833782886;
 Fri, 04 Jun 2021 12:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck> <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck> <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck> <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net> <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net> <20210604182708.GB1688170@rowland.harvard.edu>
In-Reply-To: <20210604182708.GB1688170@rowland.harvard.edu>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 12:09:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
Message-ID: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Fri, Jun 4, 2021 at 11:27 AM Alan Stern <stern@rowland.harvard.edu> wrote:
>
>         volatile_if (READ_ONCE(*x) * 0 + READ_ONCE(*y))
>                 WRITE_ONCE(*z, 42);
>
> where there is no ordering between *x and *z.

I wouldn't worry about it.

I think a compiler is allowed to optimize away stupid code.

I get upset when a compiler says "oh, that's undefined, so I will
ignore the obvious meaning of it", but that's a different thing
entirely.

I really wish that the C standards group showed some spine, and said
"there is no undefined, there is only implementation-defined". That
would solve a *lot* of problems.

But I also realize that will never happen. Because "spine" and "good
taste" is not something that I've ever heard of happening in an
industry standards committee.

Side note: it is worth noting that my version of "volatile_if()" has
an added little quirk: it _ONLY_ orders the stuff inside the
if-statement.

I do think it's worth not adding new special cases (especially that
"asm goto" hack that will generate worse code than the compiler could
do), but it means that

    x = READ_ONCE(ptr);
    volatile_if (x > 0)
        WRITE_ONCE(*z, 42);

has an ordering, but if you write it as

    x = READ_ONCE(ptr);
    volatile_if (x <= 0)
        return;
    WRITE_ONCE(*z, 42);

then I could in theory see teh compiler doing that WRITE_ONCE() as
some kind of non-control dependency.

That said, I don't actually see how the compiler could do anything
that actually broke the _semantics_ of the code. Yes, it could do the
write using a magical data dependency on the conditional and turning
it into a store on a conditional address instead (before doing the
branch), but honestly, I don't see how that would actually break
anything.

So this is more of a "in theory, the two sides are not symmetric". The
"asm volatile" in a barrier() will force the compiler to generate the
branch, and the memory clobber in barrier() will most certainly force
any stores inside the "volatile_if()" to be after the branch.

But because the memory clobber is only inside the if-statement true
case, the false case could have the compiler migrate any code in that
false thing to before the if.

Again, semantics do matter, and I don't see how the compiler could
actually break the fundamental issue of "load->conditional->store is a
fundamental ordering even without memory barriers because of basic
causality", because you can't just arbitrarily generate speculative
stores that would be visible to others.

But at the same time, that's *such* a fundamental rule that I really
am intrigued why people think "volatile_if()" is needed in reality (as
opposed to some "in theory, the compiler can know things that are
unknowable thanks to a magical oracle" BS argument)

             Linus

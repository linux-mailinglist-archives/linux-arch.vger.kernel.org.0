Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D38139BE27
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbhFDRMw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 13:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbhFDRMv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 13:12:51 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A89DC061767
        for <linux-arch@vger.kernel.org>; Fri,  4 Jun 2021 10:10:49 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id e2so12508411ljk.4
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 10:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zetK+W/bHVw7XwdBevEYPYV360JBbDIWAi5v9HH+5Ds=;
        b=USDxZZGjVEj4Wb7i/ZRsFz5JtQRbDOnr2QyyE0iZ3zBXnjTge18snA9ewptL6QC41y
         MN48LNtNkLXYStjRT0tMHo7geGbVSu7/fna5H5O2cPPqvlxYMg2Aa5UhNk3jWKr6FKwG
         k2O7oCKHoalMvnZ6FPpaxbCWmcjgFuxd6O41E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zetK+W/bHVw7XwdBevEYPYV360JBbDIWAi5v9HH+5Ds=;
        b=PSGTGAgd0DtWLbYqQf1AF3mge44ScmRDaADszlkUPbTULtXyvjJwMeKzGynINPQLyy
         y5yU8BeLPNlTijWK9U/WOQuVXREZATtSl1n8X5VgPbw8L4cQqQfJQFIWe+eSmnCNim09
         itJjFPud0gmok9NZscW+62TIe0lhEYOzc6uI8X8PSgnMIoiXz8a/1TbGoAt63WprYZf1
         73ZrYF3xbZ6aLAp4iSsAJYza/DWbNlCopg/lw9vUbYNwJWbzWIjlA7K7QbMfI1caumzX
         ZwAjJyFg28XiQfMvaONyCK6YbHTUfsckxoFI9KEtf2dbtz0hx0bKSAanNCKVizFGVv89
         UBqA==
X-Gm-Message-State: AOAM531okTM+uajRqXvGgU9hx/rcJ52UblSyPD0ORDIKONNygq+Mc40R
        YwiWVMN8Eb3kcuApjIZxcSXHy58LARqnJFTS
X-Google-Smtp-Source: ABdhPJwfsAdYkFo4TnRwBbioT7iUPLg6v5XWlXtbcy338nCETDQQlNrfVlj7hl7Gbwe6tsX49rBedw==
X-Received: by 2002:a2e:88da:: with SMTP id a26mr4168246ljk.214.1622826646993;
        Fri, 04 Jun 2021 10:10:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h13sm748366lji.101.2021.06.04.10.10.45
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 10:10:46 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id r198so11787941lff.11
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 10:10:45 -0700 (PDT)
X-Received: by 2002:a05:6512:374b:: with SMTP id a11mr3293378lfs.377.1622826645571;
 Fri, 04 Jun 2021 10:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <CAHk-=wievFk29DZgFLEFpH9yuZ0jfJqppLTJnOMvhe=+tDqgrw@mail.gmail.com> <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
In-Reply-To: <YLpWwm1lDwBaUven@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 10:10:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
Message-ID: <CAHk-=wjf-VJZd3Uxv3T3pSJYYVzyfK2--znG0VEOnNRchMGgdQ@mail.gmail.com>
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

On Fri, Jun 4, 2021 at 9:37 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> >
> > Why is "volatile_if()" not just
> >
> >        #define barier_true() ({ barrier(); 1; })
> >
> >        #define volatile_if(x) if ((x) && barrier_true())
>
> Because we weren't sure compilers weren't still allowed to optimize the
> branch away.

This isn't about some "compiler folks think".

The above CANNOT be compiled any other way than with a branch.

A compiler that optimizes a branch away is simply broken.

Of course, the actual condition (ie "x" above) has to be something
that the compiler cannot statically determine is a constant, but since
the whole - and only - point is that there will be a READ_ONCE() or
similar there, that's not an issue.

The compiler *cannot* just say "oh, I'll do that 'volatile asm
barrier' whether the condition is true or not". That would be a
fundamental compiler bug.

It's as if we wrote

    if (x) y++;

and the compiler went "Oh, I'll just increment 'y' unconditionally by
one, I'm sure the programmer doesn't mind, the conditional on 'x' is
immaterial".

No. That's not a C compiler. That's a stinking piece of buggy shit.
The compiler has to honor the conditional.

In that "y++" case, a compiler can decide to do it without a branch,
and basically rewrite the above as

   y += !!x;

but with a "volatile asm", that would be a bug.

Of course, we might want to make sure that the compiler doesn't go
"oh, empty asm, I can ignore it", but if that's the case then it's not
about "volatile_if()" any more, at that point it's "oh, the compiler
broke our 'barrier()' implementation", and we have bigger issues.

              Linus

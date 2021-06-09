Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 082BE3A1AA1
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 18:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbhFIQQU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 12:16:20 -0400
Received: from mail-oi1-f174.google.com ([209.85.167.174]:43844 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhFIQQT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Jun 2021 12:16:19 -0400
Received: by mail-oi1-f174.google.com with SMTP id x196so25198244oif.10
        for <linux-arch@vger.kernel.org>; Wed, 09 Jun 2021 09:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRuQ1mrwTnCrlmtDiCJXdi4p2uv0t05mrbfotbHVxP4=;
        b=Syg/ICcHnYjw6rdWoTK+LQM5/1dcgL/nGSedZh5kB+3YjgJxWkq9JQP8afOnaIG4mY
         rNUW83tM0U4jC5IrHzv7MvIBggWBMHgxLtOtdKOnsLO/U9kjVrausUtZZE/sVa5KM+5b
         bQu15bhQIwH+9Qmnp3Js6VFFqKGq+z7VgTMN9np8V+F0l0cEN2wBKd14N4KGIvHHy0dZ
         kYg7VO73CBikoIS1gLq0oobv9HQErz/9+brZgcKISswLFhuj3U5z4SVqPZNDYVABtIFt
         gHzl3YE6wqyEX1tHMwRZa9outDA2IBZ3dvqpHfvpRA0CzeQgZB1UHNGRKkn9No+9CK/Q
         ZOIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRuQ1mrwTnCrlmtDiCJXdi4p2uv0t05mrbfotbHVxP4=;
        b=HHBv/sq5LagW8dmXh6e46tSaUwuy6+Yc9/0lQ3mzVMI/VtYpw+aOiUDhLd9YTFQloE
         dBCNSE9dA6+RXgwri4LvlbIVT735RAQYkJaFWvax81ZI5zHeDq7KjZSnAk49loiu2r5j
         37oXp0fyjlpDO+QJ3zJVFF7pQybTCFTIzhTIoKxVnKO1zhMvVLrtEg0GwdxWI54CFkVX
         Ps8OIiKWcprknrPMclJU5Xa33zxX7NwnGmN8WWU0EJewJ63W0uGS3vwU+ZeRM4cQP9pm
         eEogbaO+dboVKMkuixWl3JLwmq8fIzoznWbo2N67xeMIniEkPmxcRvWN7C0kanaV68vP
         EHwA==
X-Gm-Message-State: AOAM533144vcmSO19bJiLguNy7S7Pz8OYrNalIuFSwLnmlzbjFo/Xrc8
        8Ei0FiR9jo/V2jAEZmslIj+nRriYiw2KJbZ7rIs7EQ==
X-Google-Smtp-Source: ABdhPJy0aaRJDIEfrAc8IuS9AgejNj9IbDlp4XC+Now9FaX0E8vRG8TSCKUChNwRdFLPMQaGCjIcEfhKZiRDzMkBNeI=
X-Received: by 2002:a05:6808:f94:: with SMTP id o20mr259047oiw.121.1623255193503;
 Wed, 09 Jun 2021 09:13:13 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com>
 <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
 <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org>
 <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com> <20210609153133.GF18427@gate.crashing.org>
In-Reply-To: <20210609153133.GF18427@gate.crashing.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 9 Jun 2021 18:13:00 +0200
Message-ID: <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
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

On Wed, 9 Jun 2021 at 17:33, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
[...]
> > An alternative design would be to use a statement attribute to only
> > enforce (C) ("__attribute__((mustcontrol))" ?).
>
> Statement attributes only exist for empty statements.  It is unclear how
> (and if!) we could support it for general statements.

Statement attributes can apply to anything -- Clang has had them apply
to non-empty statements for a while. I have
[[clang::mustcontrol]]/__attribute__((mustcontrol)) working, but of
course it's not final but helped me figure out how feasible it is
without running in circles here -- proof here:
https://reviews.llvm.org/D103958

If [1] is up-to-date, then yes, I can see that GCC currently only
supports empty statement attributes, but Clang isn't limited to empty
[2].
[1] https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html
[2] https://clang.llvm.org/docs/AttributeReference.html#statement-attributes

In fact, since C++20 [3], GCC will have to support statement
attributes on non-empty statements, so presumably the parsing logic
should already be there.
[3] https://en.cppreference.com/w/cpp/language/attributes/likely

> Some new builtin seems to fit the requirements better?  I haven't looked
> too closely though.

I had a longer discussion with someone offline about it, and the
problem with a builtin is similar to the "memory_order_consume
implementation problem" -- you might have an expression that uses the
builtin in some function without any control, and merely returns the
result of the expression as a result. If that function is in another
compilation unit, it then becomes difficult to propagate this
information without somehow making it part of the type system.
Therefore, by using a statement attribute on conditional control
statements, we do not even have this problem. It seems cleaner
syntactically than having a __builtin_() that is either approximate,
or gives an error if used in the wrong context.

Hence the suggestion for a very simple attribute, which also
side-steps this problem.

Thanks,
-- Marco

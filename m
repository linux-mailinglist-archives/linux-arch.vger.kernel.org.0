Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8E3039D052
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFFSIQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 14:08:16 -0400
Received: from mail-lf1-f47.google.com ([209.85.167.47]:43874 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFFSIP (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 14:08:15 -0400
Received: by mail-lf1-f47.google.com with SMTP id n12so15195271lft.10
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKuybgAgyMzO4iU5BpZa8HSbFtwDUcG15B2kgwy+X7k=;
        b=Vwi8eTi4MMgQuYuMgETnEHOG+sdOEJb1xqe2bu3Mu/2iXPXjzsiiznTXkVldkwp79G
         E4f1aGtVZ43PmoTSSFQzhnamjffmb7R6KK5l4lg4HhcZpXbn9GwkZWegF+rYlLpFp50F
         J6wseJWJe+NJg8yIQ/He6C14rbg9zHt68fZOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKuybgAgyMzO4iU5BpZa8HSbFtwDUcG15B2kgwy+X7k=;
        b=it3Z08wrMyzWguJ0X0stFLP06BDz8/RUV/F7dPe1n/Wd8ZnJufzXqS26RF4rOoeh97
         bApnznrCgLl4TRtozRPVfC9OTaGtjHevKRANctKswmzUhv/9kcTSX5kdAk5O/bfYHvnk
         8+d0gvPCvMrKRXzFUpPZ1f/xaMyaBsdBZvxWMcH9KjtvSLCIV6ptsQ+0jVBD6+Er+Mzc
         u4LArz+Sr4WKXaWQZlE4PrOSLX44t8tpMm9GHtxBBCGtMj3iCAcwQb6/FbftkvumY5gB
         Qdquej7cRSxyO9DvQ0ulfPB0SuP4XsZ7FmVGqTn8jvh5vZfq3gWP80mU2A3B+Ophlm4d
         a0BQ==
X-Gm-Message-State: AOAM530hSiPaFGExJu57s1dOY/6LgJM/Xv+FwH8svpT1MOJlBmqadQIV
        DNWMj2g7y1G12FVUHcV7uAIpgQpj9/fNCS9AFf8=
X-Google-Smtp-Source: ABdhPJzTFb+t1eNDv/34WWwW1JfdHOYRfcQyYmB6JfkXj/X2s8y5eS97HW6E2m1mTyb+V9FcZ32NwA==
X-Received: by 2002:ac2:428e:: with SMTP id m14mr9296745lfh.478.1623002708338;
        Sun, 06 Jun 2021 11:05:08 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id 131sm1211854lfm.127.2021.06.06.11.05.06
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:05:06 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id a2so22201000lfc.9
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 11:05:06 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr9071498lfa.421.1623002705722;
 Sun, 06 Jun 2021 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210604182708.GB1688170@rowland.harvard.edu> <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
In-Reply-To: <20210606115336.GS18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:04:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
Message-ID: <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Sun, Jun 6, 2021 at 4:56 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> And that is a simple fact, since the same assembler code (at the same
> spot in the program) will do the same thing no matter how that ended up
> there.

The thing is, that's exactl;y what gcc violates.

The example - you may not have been cc'd personally on that one - was
something like

    if (READ_ONCE(a)) {
        barrier();
        WRITE_ONCE(b,1);
   } else {
        barrier();
        WRITE_ONCE(b, 1);
    }

and currently because gcc thinks "same exact code", it will actually
optimize this to (pseudo-asm):

    LD A
    "empty asm"
    ST $1,B

which is very much NOT equivalent to

    LD A
    BEQ over
    "empty asm"
    ST $1,B
    JMP join

over:
    "empty asm"
    ST $1,B

join:

and that's the whole point of the barriers.

It's not equivalent exactly because of memory ordering. In the first
case, there is no ordering on weak architectures. In the second case,
there is always an ordering, because of CPU consistency guarantees.

And no, gcc doesn't understand about memory ordering. But that's
exactly why we use inline asms.

> And the compiler always is allowed to duplicate, join, delete, you name
> it, inline assembler code.  The only thing that it cares about is
> semantics of the code, just like for any other code.

See, but it VIOLATES the semantics of the code.

You can't join those two empty asm's (and then remove the branch),
because the semantics of the code really aren't the same any more if
you do. Truly.

              Linus

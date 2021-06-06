Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4BF39D138
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbhFFUPE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 16:15:04 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:36509 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhFFUPD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Jun 2021 16:15:03 -0400
Received: by mail-lf1-f51.google.com with SMTP id v22so21216196lfa.3
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9Dgzkc6mzoKadrti0reRjEb/MNcsn0/HLVhWdAcN2E=;
        b=elCGeQWQ76a+XOXQPuapVBLMfPQKtXSartHcDBKR3BXRhLQUQ1oigbVKib9h/4m4qI
         uhVlgq6rpANSWCwav3vtsQ98Pq9CRLAd5IFkrs0e5UJuq047ZkqZ2jZTnt7Z6iLKI4dC
         yKLcJ7tRcQNXK+WF2+PHQlsrWV/8w+4ygZ/OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9Dgzkc6mzoKadrti0reRjEb/MNcsn0/HLVhWdAcN2E=;
        b=rqd7FTCrQWo/3ml9X+74oXNjHvQbxn+6Y6Uo/r8/MlveLIoZP9rkmFWo+frOyUKhG5
         kMW1UeWpCQxNMTgQukbRMRCWkMjRWJNBAncDNcm8dJipxtjIirgA4fkV4zXw8Rdf3MxW
         wEOfi+mpiRDOYnomDOVTTLh9N33iGhx1oxcyS0JX5QiYdc4XsxxWKBwcb2ThpzFRlAix
         UsSh8EcUku223iba5A775u96fLYWAGHJ8bkICL9zD5wjpr8aUQVyYDf8et2mqjUMN1h0
         FzaxnL43Dp8+2G+cBjQmsjlfSJvEg9ZhYPCOb93dWHEgqQ97Ygr47SgieAK6lnI21EzE
         zDYg==
X-Gm-Message-State: AOAM533yttzpbHMQ0jdxp5Ho6gs88UYQLc1iKN0SOs67F303vl/7EtmM
        fySUcuq3UhXE6abFVKCykeSVAggkjbsskLBB+bU=
X-Google-Smtp-Source: ABdhPJzg5ThTNSa92g9C00R31/mLOo4c4VVMLsK0hB7AJz9n77EscCp5ib20S1eagr0sp1inGBaPNQ==
X-Received: by 2002:ac2:4109:: with SMTP id b9mr8206636lfi.566.1623010332396;
        Sun, 06 Jun 2021 13:12:12 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id r17sm1558301ljp.40.2021.06.06.13.12.09
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 13:12:10 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id f11so22467359lfq.4
        for <linux-arch@vger.kernel.org>; Sun, 06 Jun 2021 13:12:09 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr9324319lfc.201.1623010329434;
 Sun, 06 Jun 2021 13:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
 <20210606195242.GA18427@gate.crashing.org>
In-Reply-To: <20210606195242.GA18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 13:11:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
Message-ID: <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
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

On Sun, Jun 6, 2021 at 12:56 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Yes, I know.  But it is literally the *only* way to *always* get a
> conditional branch: by writing one.

The thing is, I don't actually believe you.

The barrier() thing can work - all we need to do is to simply make it
impossible for gcc to validly create anything but a conditional
branch.

If either side of the thing have an asm that cannot be combined, gcc
simply doesn't have any choice in the matter. There's no other valid
model than a conditional branch around it (of some sort - doing an
indirect branch that has a data dependency isn't wrong either, it just
wouldn't be something that a sane compiler would generate because it's
obviously much slower and more complicated).

We are very used to just making the compiler generate the code we
need. That is, fundamentally, what any use of inline asm is all about.
We want the compiler to generate all the common cases and all the
regular instructions.

The conditional branch itself - and the instructions leading up to it
- are exactly those "common regular instructions" that we'd want the
compiler to generate. That is in fact more true here than for most
inline asm, exactly because there are so many different possible
combinations of conditional branches (equal, not equal, less than,..)
and so many ways to generate the code that generates the condition.

So we are much better off letting the compiler do all that for us -
it's very much what the compiler is good at.

               Linus

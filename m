Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB1E39E878
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 22:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFGUdk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231287AbhFGUdj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Jun 2021 16:33:39 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD54C061574
        for <linux-arch@vger.kernel.org>; Mon,  7 Jun 2021 13:31:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id r198so25099156lff.11
        for <linux-arch@vger.kernel.org>; Mon, 07 Jun 2021 13:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kteMWI8wqvnKbw9QPTVRDBy7GPMe911SvO5GJ7EDIIo=;
        b=DBmsALCCUaGl/AsAhStDaRku1s3wuNNlysYwZV3avf0trIA4fgd3qdx/kJYwf3UO6P
         RVujQzv/zjbuLQIcZqiN0YqSfz9j8Ek1UF2WTIdcppVu2J0t0BJMi2j8GvoUqTRSapAQ
         URU9aCCc0d1NcbPLvHkwwQ2JUUTVGUza1ifOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kteMWI8wqvnKbw9QPTVRDBy7GPMe911SvO5GJ7EDIIo=;
        b=b8fjly0rnWwz75WfWhjjNvdNFI1CKWwDzc3cLNtvTxMMGAPqPyXb/FYh/t90Zb+Pg0
         KdEO5t5nRWGBvov3aTndMGQYdo/GKC5AwnPHoyrIYUZCO3Us23gN9Pud+HMv4BdiBPDE
         a+frWxQ7uFQcVfF4MzNdInCVfsweWX2HH1M2loWsvBijNE4D5LTRCwggkWkdQ3o7+ERP
         KuNKnjNvawo7O9psKMx6Ieurw8e2uGjr8bdF1AG9TRt7iltlWmp3yP7Th/sADY5Tekew
         S5eJf5HKLZzbG7xXDzKe/K5fObHbKCB2EzZF+eGjba264m+JLEneGXN6sXwUYtWiXjia
         /CNw==
X-Gm-Message-State: AOAM531y1YtHNoB8QBduhfJLfoEUBFLjk0tuzJQnH7RMoG9mJCOLobD+
        8bp9vYai7Jp9MR8dTjvNVazm6z+moVIUbxJLXvg=
X-Google-Smtp-Source: ABdhPJydoMzcVeRf48UuCLF5cFw688wohmJHuPLmNwdhdpfgs2vRkPbIADPj5RoBYkQYgJ6xlmUXPQ==
X-Received: by 2002:ac2:5d29:: with SMTP id i9mr12873407lfb.638.1623097903071;
        Mon, 07 Jun 2021 13:31:43 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id i21sm1949921ljb.10.2021.06.07.13.31.41
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 13:31:41 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id t7so21341889lff.0
        for <linux-arch@vger.kernel.org>; Mon, 07 Jun 2021 13:31:41 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr12594362lfa.421.1623097901047;
 Mon, 07 Jun 2021 13:31:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <20210607174206.GF18427@gate.crashing.org>
In-Reply-To: <20210607174206.GF18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Jun 2021 13:31:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOTcBuxx1pYj=mQz-f0dvhbxq2a=ricTuHH5xwUKE5Yw@mail.gmail.com>
Message-ID: <CAHk-=wiOTcBuxx1pYj=mQz-f0dvhbxq2a=ricTuHH5xwUKE5Yw@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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

On Mon, Jun 7, 2021 at 10:45 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> On Sun, Jun 06, 2021 at 03:38:06PM -0700, Linus Torvalds wrote:
> >
> > Example: variable_test_bit(), which generates a "bt" instruction, does
> >
> >                      : "m" (*(unsigned long *)addr), "Ir" (nr) : "memory");
> >
> > and the memory clobber is obviously wrong: 'bt' only *reads* memory,
> > but since the whole reason we use it is that it's not just that word
> > at address 'addr', in order to make sure that any previous writes are
> > actually stable in memory, we use that "memory" clobber.
>
> You can split the "I" version from the "r" version, it does not need
> the memory clobber.  If you know the actual maximum bit offset used you
> don't need the clobber for "r" either.  Or you could even write
>   "m"(((unsigned long *)addr)[nr/32])
> That should work for all cases.

Note that the bit test thing really was just an example.

And some other cases don't actually have an address range at all,
because they affect arbitrary ranges, not - like that bit test - just
one particular range.

To pick a couple of examples of that, think of

 (a) write memory barrier. On some architectures it's an explicit
instruction, on x86 it's just a compiler barrier, since writes are
ordered on the CPU anyway, and we only need to make sure that the
compiler doesn't re-order writes around the barrier

Again, we currently use that same "barrier()" macro for that:

    #define __smp_wmb()     barrier()

but as mentioned, the barrier() thing has a "memory" clobber, and that
means that this write barrier - which is really really cheap on x86 -
also unnecessarily ends up causing pointless reloads from globals. It
obviously doesn't actually *change* memory, but it very much requires
that writes are not moved around it.

 (b) things like cache flush and/or invalidate instructions, eg

        asm volatile("wbinvd": : :"memory");

Again, this one doesn't actually *modify* memory, and honestly, this
one is not performance critical so the memory clobber is not actually
a problem, but I'm pointing it out as an example of the exact same
issue: the notion of an instruction that we don't want _writes_ to
move around, but reads can happily be moved and/or cached around it.

 (c) this whole "volatile_if()" situation: we want to make sure writes
can't move around it, but there's no reason to re-load memory values,
because it doesn't modify memory, and we only need to make sure that
any writes are delayed to after the conditional.

We long long ago (over 20 years by now) used to do things like this:

  struct __dummy { unsigned long a[100]; };
  #define ADDR (*(volatile struct __dummy *) addr)

      __asm__ __volatile__(
              "btl %2,%1\n\tsbbl %0,%0"
              :"=r" (oldbit)
              :"m" (ADDR),"ir" (nr));

for that test-bit thing. Note how the above doesn't need the memory
clobber, because for gcc that ADDR thing (access to a big struct) ends
up being a "BLKmode" read, and then gcc at least used to treat it as
an arbitrary read.

I forget just why we had to stop using that trick, I think it caused
some reload confusion for some gcc version at some point. Probably
exactly because inline asms had issues with some BLKmode thing. That
change happened before 2001, we didn't have nice changelogs with
detailed commit messages back then, so

> > Anybody have ideas or suggestions for something like that?
>
> Is it useful in general for the kernel to have separate "read" and
> "write" clobbers in asm expressions?  And for other applications?

See above. It's actually not all that uncommon that you have a "this
doesn't modify memory, but you can't move writes around it". It's
usually very much about cache handling or memory ordering operations,
and that bit test example was probably a bad example exactly because
it made it look like it's about some controlled range.

The "write memory barroer" is likely the best and simplest example,
but it's in not the only one.

            Linus

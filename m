Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0739F272
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 11:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFHJd5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 05:33:57 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:33396 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbhFHJd4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Jun 2021 05:33:56 -0400
Received: by mail-ot1-f53.google.com with SMTP id o17-20020a9d76510000b02903eabfc221a9so5976235otl.0
        for <linux-arch@vger.kernel.org>; Tue, 08 Jun 2021 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FvaXKeONQFxo34sivuEdEKgjJnzHpcZdKXU5suavL3s=;
        b=ACxTqIGbgk1whgSG6vfM9Vy1wIBKjlBRE3Z9SU8OLHBOexIdgLYNGLTpKz+EP6rLNQ
         Jc8jFUF+g9c0bcAM4TBO0Rih1j4Ibw9hDEsRnsKGwygUDulR33/96Dw6SHmZiXFfepV7
         3XlSwiVy2zgXz2AKiwvufY3S7bbwBmmthmyxxys29jlabDSVfdPM7clNLUeatlM1ZCQS
         NWEX776j8nTfmuuAJsSjzMUgUfpIRsTwG8GTIngf7Cvhme34miR0tbGXW3jA87JYCTZQ
         DTPaZJ239q/BFxZ0lmLQQGyxxL9IYAHydk8WjfGAKbXmT8yiuAmaztW6hDrIsgri30N2
         UdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FvaXKeONQFxo34sivuEdEKgjJnzHpcZdKXU5suavL3s=;
        b=hRbaXkLZ7sYJ4qrZ7vuZzjk673FYWT8QZLpL0bCVuq6IDQfgSE9kfd4JAA8dQpAT3V
         XNY65R4WhYuq1sA4nwHeTovroFADo1T6P8V1cFLyl+DtjO7C9uuGJMvzfjLe6hMaqKRm
         ilF/ac0dRPPEX1SRy68yZWrOKtLZ9/bLhiLBoRq0E3MVoTCH38LEHQX108OueM6+0ked
         wcthYuPhT0YkizPYsRs5/ixtbbgSh090O+KHffd1BcnDa7Yid0I11XoS98DpU+CX+9jV
         TBdA0uoFV1zks5YcR9wQZoJp394q5vWXOheSXIDs8q9xkKJIW23Jn0WEiIdJrngdUk9O
         uiNg==
X-Gm-Message-State: AOAM531r1yW3MpP5PHg5v6g9kzx8uXLW9HrrjXxDYVghzRJdQaoYA150
        RKWn2Q4x/Ff2f1Po2Ok0VH2BoJquoFNkfjiKBopxbA==
X-Google-Smtp-Source: ABdhPJyp8/T+kwoUg2DcTYJ5gr1PTHz3UqoIPkJ8q67EVBhtTUNNSZfLN912e4+fM6AenqWxmbsCrhsOtfGqiWhOLXs=
X-Received: by 2002:a05:6830:1c7b:: with SMTP id s27mr3552631otg.233.1623144651784;
 Tue, 08 Jun 2021 02:30:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru>
 <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com>
 <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru>
 <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com>
 <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com>
In-Reply-To: <YL5Risa6sFgnvvnG@elver.google.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 8 Jun 2021 11:30:36 +0200
Message-ID: <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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

On Mon, 7 Jun 2021 at 19:04, Marco Elver <elver@google.com> wrote:
[...]
> > > > So the barrier which is a compiler barrier but not a machine barrier is
> > > > __atomic_signal_fence(model), but internally GCC will not treat it smarter
> > > > than an asm-with-memory-clobber today.
> > >
> > > FWIW, Clang seems to be cleverer about it, and seems to do the optimal
> > > thing if I use a __atomic_signal_fence(__ATOMIC_RELEASE):
> > > https://godbolt.org/z/4v5xojqaY
> >
> > Indeed it does!  But I don't know of a guarantee for that helpful
> > behavior.
>
> Is there a way we can interpret the standard in such a way that it
> should be guaranteed?

I figured out why it works, and unfortunately it's suboptimal codegen.
In LLVM __atomic_signal_fence() turns into a real IR instruction,
which when lowered to asm just doesn't emit anything. But most
optimizations happen before in IR, and a "fence" cannot be removed.
Essentially imagine there's an invisible instruction, which explains
why it does what it does. Sadly we can't rely on that.

> The jumping-through-hoops variant would probably be asking for a
> __builtin primitive that allows constructing volatile_if() (if we can't
> bend existing primitives to do what we want).

I had a think about this. I think if we ask for some primitive
compiler support, "volatile if" as the target is suboptimal design,
because it somewhat limits composability (and of course make it hard
to get as an extension). That primitive should probably also support
for/while/switch. But "volatile if" would also preclude us from
limiting the scope of the source of forced dependency, e.g. say we
have "if (A && B)", but we only care about A.

The cleaner approach would be an expression wrapper, e.g. "if
(ctrl_depends(A) && B) { ... }".

I imagine syntactically it'd be similar to __builtin_expect(..). I
think that's also easier to request an extension for, say
__builtin_ctrl_depends(expr). (If that is appealing, we can try and
propose it as std::ctrl_depends() along with std::dependent_ptr<>.)

Thoughts?

Thanks,
-- Marco

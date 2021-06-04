Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5981039C266
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 23:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbhFDVa4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 17:30:56 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:46031 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFDVa4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 17:30:56 -0400
Received: by mail-lf1-f53.google.com with SMTP id a1so6417851lfr.12
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 14:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vqbfjblR/Fp3P2h3qiOe1azluCNc6CBrjPxj4wpsU9I=;
        b=fqhZ6hw/3lvFC2pfC1mskQl7xa1ebQec/aO6Dr+ZUhXxK5ZEi25KRnsNE8WdSxPVLa
         hOrUA2DQRAl/2sADVKRFZyEIjKmI7F6V+jOq3OWoQ1K8pODm1DtyGOC9b+Bqt7OEvypT
         4LQuWX3di+ayYmQsuxJXSJ20UQNil0qWLAr8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vqbfjblR/Fp3P2h3qiOe1azluCNc6CBrjPxj4wpsU9I=;
        b=qOZp/8YMoeaTOq4FRVKRRR2dcTL4HB4IBIPzGpPnhlCgONcLCmjTYfhDFiKUiSpvkz
         kVsaela4CaHoKzwYwC1S9RasGovaKik4q2P7qNrMcirTU9pVr/DqTrGVPsDDU4+p9a7R
         X/rKzBokqyiEDEq5P+Bz+GpA9VykkjNMbur1+nCnzdJRUhdAIYhixIOwUaufOpA05fgg
         7fAC4Daw8GI0rNiLSux36kjhtv6KnbZnGTKg2lsJL8Wn1A00HPgg/gSAGJIa2aBZjXgQ
         v1W7GgGgToGAqkLG9ZLWkLWOj8CqMHwn4/M33Jtqr5QYVbmy18QP9GCz58Cwwa2CN+NF
         0j3w==
X-Gm-Message-State: AOAM530P/w5CLkqRSpPLZ0s6S+VuooKqxO5+HsZcIPA6gY6PEFclsTIj
        pZ7Ai7bo0Em6P27n3IKiHiLcTJAvPNXyaXs0duI=
X-Google-Smtp-Source: ABdhPJwApHMTdQMbUKKH6LgWEs9PkcHTzsEhh0Jq2d8uaDZyF1mrtUnP6jwcDX2I7l3QBedvvvCY1Q==
X-Received: by 2002:a05:6512:3255:: with SMTP id c21mr4156618lfr.634.1622842088124;
        Fri, 04 Jun 2021 14:28:08 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id a20sm822231ljn.94.2021.06.04.14.28.06
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 14:28:06 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id c11so13313470ljd.6
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 14:28:06 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr4809729ljd.411.1622842085894;
 Fri, 04 Jun 2021 14:28:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210604134422.GA2793@willie-the-truck> <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck> <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net> <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net> <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com> <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 14:27:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
Message-ID: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
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

On Fri, Jun 4, 2021 at 1:56 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> The usual way to prevent it is to use WRITE_ONCE().

The very *documentation example* for "volatile_if()" uses that WRITE_ONCE().

IOW, the patch that started this discussion has this comment in it:

+/**
+ * volatile_if() - Provide a control-dependency
+ *
+ * volatile_if(READ_ONCE(A))
+ *     WRITE_ONCE(B, 1);
+ *
+ * will ensure that the STORE to B happens after the LOAD of A.

and my point is that I don't see *ANY THEORETICALLY POSSIBLE* way that
that "volatile_if()" could not be just a perfectly regular "if ()".

Can you?

Because we *literally* depend on the fundamental concept of causality
to make the hardware not re-order those operations.

That is the WHOLE AND ONLY point of this whole construct: we're
avoiding a possibly expensive hardware barrier operation, because we
know we have a more fundamental barrier that is INHERENT TO THE
OPERATION.

And I cannot for the life of me see how a compiler can break that
fundamental concept of causality either.

Seriously. Tell me how a compiler could _possibly_ turn that into
something that breaks the fundamental causal relationship. The same
fundamental causal relationship that is the whole and only reason we
don't need a memory barrier for the hardware.

And no, there is not a way in hell that the above can be written with
some kind of semantically visible speculative store without the
compiler being a total pile of garbage that wouldn't be usable for
compiling a kernel with.

If your argument is that the compiler can magically insert speculative
stores that can then be overwritten later, then MY argument is that
such a compiler could do that for *ANYTHING*. "volatile_if()" wouldn't
save us.

If that's valid compiler behavior in your opinion, then we have
exactly two options:

 (a) give up

 (b) not use that broken garbage of a compiler.

So I can certainly accept the patch with the simpler implementation of
"volatile_if()", but dammit, I want to see an actual real example
arguing for why it would be relevant and why the compiler would need
our help.

Because the EXACT VERY EXAMPLE that was in the patch as-is sure as
hell is no such thing.

If the intent is to *document* that "this conditional is part of a
load-conditional-store memory ordering pattern, then that is one
thing. But if that's the intent, then we might as well just write it
as

    #define volatile_if(x) if (x)

and add a *comment* about why this kind of sequence doesn't need a
memory barrier.

I'd much rather have that kind of documentation, than have barriers
that are magical for theoretical compiler issues that aren't real, and
don't have any grounding in reality.

Without a real and valid example of how this could matter, this is
just voodoo programming.

We don't actually need to walk three times widdershins around the
computer before compiling the kernel.That's not how kernel development
works.

And we don't need to add a "volatile_if()" with magical barriers that
have no possibility of having real semantic meaning.

So I want to know what the semantic meaning of volatile_if() would be,
and why it fixes anything that a plain "if()" wouldn't. I want to see
the sequence where that "volatile_if()" actually *fixes* something.

              Linus

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA50F41F4E3
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 20:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355705AbhJASUp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 14:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355744AbhJASUo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 14:20:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1756C0613E2
        for <linux-arch@vger.kernel.org>; Fri,  1 Oct 2021 11:18:58 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z24so42099742lfu.13
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 11:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UuvJOD3DzRGmVW6xcad8F/v9YB5VsSRjw/nzs5q47b4=;
        b=MgDHcdJSmX13uyCrfEHU0FYoJQ1hXzA5UW2GY94/ufFm/9Qq3zH15vPjnENcyoArkK
         FU67Ww/nLrIPvwuOcYozEGxrgnmYrE/xtwICCE/8r8Fq7gG7HGJlLyPDKnPGIQOpwv4h
         TG9h2lpDce0CjWYasQzV5YqhInUJMedEFM9PM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuvJOD3DzRGmVW6xcad8F/v9YB5VsSRjw/nzs5q47b4=;
        b=SGcyIgQB+hoUsB2n4h8GccVHIywHH41CNGUZHiWJQwO6xKCLF4e5XygH9n1RnBSl2z
         aCZ6ppvCL4gJh4a+aXGbxTWCSYbrlXyb4OWfvLn4KWht4ePCtT2obCD+l7s1pF+5RBCl
         C+VYEyWAtNgDesFNVcrbDRSC2aEJsjNtcHWNDw3AoeyJ8ngkt3n+B/4YC5iJMkXP6SUN
         1XNjsu2bP0AHECDoZ3Ipm8xW97q6RAaAAexuUSV6E9hIBjl8d2+I8RYWnk8CPc33pGVb
         4TrH1g6T/RnOl5AChmbiza/pt/DtxnLHqqbrgdNCKzmhMy2tZNpQqhmNC8gdO9e4KYfu
         1D0w==
X-Gm-Message-State: AOAM531EVmqjG2hH1OstgkuQYoN50dnc+tPlwb/F0MZQvmQZ8G8y5Ou5
        x2FiliF5QxtUHFo0FyALUXVgng67dAwZwA6HWUU=
X-Google-Smtp-Source: ABdhPJxkTCRtvBU3XPolpgaR7qGIrOaSWVVCh84HvAplAbQLpMM2h7dRJFT4bj4VkukCWJKlb+XTzA==
X-Received: by 2002:a2e:611a:: with SMTP id v26mr13534069ljb.122.1633112336774;
        Fri, 01 Oct 2021 11:18:56 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id a7sm731774ljd.85.2021.10.01.11.18.53
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 11:18:54 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id x27so42096128lfu.5
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 11:18:53 -0700 (PDT)
X-Received: by 2002:ac2:51a6:: with SMTP id f6mr147804lfk.150.1633112333146;
 Fri, 01 Oct 2021 11:18:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <YVRWyq+rDeAFLx+X@elver.google.com> <1340204910.47919.1633103136293.JavaMail.zimbra@efficios.com>
 <CAHk-=whcN4ACLFvst0THwwpUFK4DDSM4O_frSoUQJ1m+0ENWjw@mail.gmail.com> <1097444747.48074.1633109281556.JavaMail.zimbra@efficios.com>
In-Reply-To: <1097444747.48074.1633109281556.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Oct 2021 11:18:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=whi_B36yw9Haw3sfSQhF7+Y1=bn_y2S=DwZ533yuF=izw@mail.gmail.com>
Message-ID: <CAHk-=whi_B36yw9Haw3sfSQhF7+Y1=bn_y2S=DwZ533yuF=izw@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        paulmck <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 1, 2021 at 10:28 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> I've spent some quality time staring at generated assembler diff in the past
> days, and looking for code patterns of refcount_dec_and_test users, without
> much success. There are some cases which end up working by chance, e.g. in
> cases where the if leg has a smp_acquire__after_ctrl_dep and the else leg has
> code that emits a barrier(), but I did not find any buggy generated
> code per se. In order to observe those issues in real life, we would
> really need to have identical then/else legs to the branch.

Yeah, that's been very much my feeling too during this whole
discussion (including, very much, earlier threads).

All the examples about this being a problem are those kinds of
"identical or near-identical if/else statements" and they just don't
seem to be all that realistic.

Because immediately when the if-statement actually does something
_meaningful_, it just turns into a branch. And when people use atomics
- even the weak READ/WRITE_ONCE() kinds of things, never mind anything
stronger - it really doesn't give the compiler the option to move
things around all that much.

There's a reason the source code uses an if-statement, after all: that
is literally the logical code flow, and people write a very particular
dependency chain that is just very fundamental.

Having essentially the same thing on both sides just isn't a realistic
thing to do, and if it were - and you cared about performance in that
case, which is what this is all about, after all - you'd write it very
differently.

                Linus

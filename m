Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96EEA41F20B
	for <lists+linux-arch@lfdr.de>; Fri,  1 Oct 2021 18:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354121AbhJAQWL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Oct 2021 12:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbhJAQWJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Oct 2021 12:22:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74B0C061775
        for <linux-arch@vger.kernel.org>; Fri,  1 Oct 2021 09:20:24 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id y23so1520718lfb.0
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 09:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w/+Hq8UqlfFcP1UMtUx6Es8qH5H9I5FridpZNQE+lVw=;
        b=hX2D0s8M12QFevuX2OnCZiOJ+yX/wjiFBKYhaDfYdKAwR9d8Bo5fiD2Iz0P84weoxj
         KRS9RFJE30Vdg1wN49NJ3v5otKzBZgHY/Sb8c4vTqPS1XiQ8XcFihWILRRa/rJkxo6hy
         Ju1QzoEEGhBOvZA8Pq76isjZq9jjJHS02RnB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w/+Hq8UqlfFcP1UMtUx6Es8qH5H9I5FridpZNQE+lVw=;
        b=jvhIJ5SB4VbhCWCC/rc8qzvfSE0k2gF97ZYJaVkfpolBwtJgu4mWFaucYqvo2hpGbi
         VDpIrSiAkExxKuDnb4rwiVALiN34GU+KN+zmcuhX+7UfbaKgIYnIoiWKUEzkyMqskOwH
         sEwl0rhLaAun6Aqa8Z3zlhSMMZIu97r2RAYpXak26AXFKDRk77Sf0i32hn9eg8IdGOzO
         yegI7YWtPHdeZqMsYT2sQwEaV/CoB+ca9ZyJp2c+P9/XTKxmUdeCtLmSNnhFUX7x4kJL
         kG6cJ1zacM2pDCbAHkrvYAusK4c+b3enIXT1iXs0qWfOu79P3V3gXyxpXccTuRe5qLC/
         P1jg==
X-Gm-Message-State: AOAM531jUDRG5k67BYs1pUnvCmpkUq3d/zr/99NpFH/ZxqFCGFehAMeT
        8+YVz7lKJYSGsspApkoGUBAiTlqgssHkKPii
X-Google-Smtp-Source: ABdhPJz1EHmiCNG1beb5vEDdoidFkVKaC3KkDWP7HYNNTdaqrUhp/hyCVJjz+czolWhPp5TYIHZjsQ==
X-Received: by 2002:a2e:7203:: with SMTP id n3mr13076224ljc.195.1633105222902;
        Fri, 01 Oct 2021 09:20:22 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id n26sm780838lfe.72.2021.10.01.09.20.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 09:20:20 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id g41so40539514lfv.1
        for <linux-arch@vger.kernel.org>; Fri, 01 Oct 2021 09:20:19 -0700 (PDT)
X-Received: by 2002:a05:651c:1250:: with SMTP id h16mr13473494ljh.68.1633105218997;
 Fri, 01 Oct 2021 09:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <YVRWyq+rDeAFLx+X@elver.google.com> <1340204910.47919.1633103136293.JavaMail.zimbra@efficios.com>
In-Reply-To: <1340204910.47919.1633103136293.JavaMail.zimbra@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Oct 2021 09:20:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=whcN4ACLFvst0THwwpUFK4DDSM4O_frSoUQJ1m+0ENWjw@mail.gmail.com>
Message-ID: <CAHk-=whcN4ACLFvst0THwwpUFK4DDSM4O_frSoUQJ1m+0ENWjw@mail.gmail.com>
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

On Fri, Oct 1, 2021 at 8:45 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Well AFAIU, this example with cinc does guarantee the control dependency for the store
> to "y". The issue arises if we have additional stores which are also expected to be
> ordered by the control dependency, e.g.:
>
>         if (READ_ONCE(x)) {
>                 WRITE_ONCE(y, 1);
>         } else {
>                 WRITE_ONCE(y, 2);
>         }
>         WRITE_ONCE(z, 3);
>
> Here the store to "z" would not necessarily be ordered by the control dependency.

Actually, it is ordered as far as the *compiler* is concerned.

It's just that the two writes to 'y' might become a data dependency
(ie using a cmov or arithmetic tricks like 'adc'), then the hardware
might end up considering the write to 'z' to not have any dependencies
and be done early.

> Likewise with clang if we store the same value to different memory locations, e.g.:
>
>         if (READ_ONCE(x)) {
>                 WRITE_ONCE(a, 0);
>         } else {
>                 WRITE_ONCE(b, 0);
>         }
>         WRITE_ONCE(z, 3);
>
> With armv8, the csel instruction is done on the address being written to, which also
> removes the conditional branch. I think this last example is missing from the kernel
> documentation.

Note that the important part isn't necessarily the "control" part of
the dependency.

A *data* dependency is equally strong and valid, and orders the write
wrt the read too.

IOW, this chain is ordered:

     WRITE_ONCE(a, READ_ONCE(b));

without any control dependencies at all. The CPU fundamentally cannot
do the write before it has done the read.

So turning a control dependency into a data dependency DOES NOT remove
the ordering. It's fine. And it doesn't matter whether the data
dependency is on the actual stored data, or on the stored address. In
both cases it's a dependency, and the store cannot be done before the
load.

(NOTE! The CPU _internally_ might speculate the store address or store
data, and thus "do the store first". But it cannot become _visible_ to
anybody else before the speculation has been validated, so from a
memory ordering standpoint, the load always happens first - even if
the CPU internally might have done parts of the store before. All that
matters is the _effective_ memory ordering visible externally, not the
order in which the CPU did things).

Of course, the issue with a data dependency is that it's then "local
to that data". The example above with the write to 'z' is probably a
good example. If the "if ()" statement ends up visible to the CPU as
control flow, then the READ_ONCE(x) is ordered wrt the WRITE_ONCE(z).

But if the conditional WRITE_ONCE(a/b) ends up being done as a data
dependency on the address (or the store data), then the WRITE_ONCE(z)
is ordered in the instruction stream (because those are the C volatile
semantics), but could be visible out of order thanks to CPU memory
ordering.

But again - a lot of these made-up examples are exactly that: made up.
For us to have a ctrl_dep() macro, I really want to see an actual
honest-to-goodness case of this that we can point to.

               Linus

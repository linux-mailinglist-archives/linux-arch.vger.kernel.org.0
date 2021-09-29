Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 179D641C72E
	for <lists+linux-arch@lfdr.de>; Wed, 29 Sep 2021 16:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344637AbhI2Ot1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 29 Sep 2021 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344459AbhI2OtY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 29 Sep 2021 10:49:24 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC13C06161C
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:47:42 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id e15so11788065lfr.10
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFg4AyxhOkrmj2m8GgLtBQsrwYL1m+vTuPDFyai2hnY=;
        b=TY3qm/59v0pVhETMeEmyrWKW7NYyHv2byd9LPTTDbwJuw+CRiLITgNlDDc497mHhda
         d61B42xvJ6U8Pd7AaGSizo8l0egJjeRfPlUcf2o9aMPSFuwM0Bjbu2N2fMTQl1dE4ofc
         G4kTQ1xx9fokfRymsuyrGUocPFZ4ADZ9Xay2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFg4AyxhOkrmj2m8GgLtBQsrwYL1m+vTuPDFyai2hnY=;
        b=xJ0my3jEA9AWofvvN8hZOF5dc6DWSQgXcfGPhWyoLqgHhGB/kB5/UC83QzkaOUme5T
         ReLqTAC3lIuYwIHBQR2CGlxCkMdOOyF+JI7DMnxc+Y4wkBbhMTG97PVdMonybHPWYjsa
         CAybS1ml1NAFBevvwIlwzfa3klnArAiOI6NmflTeza4Y4BS7GUCyQWFadz9LpVUcjruw
         ECnL2DktEzi/tA50UG1TqOWi0a+hbayx8rA+KjI0EmMNILVe2Z1qTFGrmM40sHWmdelA
         g8SHyerBCsiRIIebnXARldOOtD7ZBBssezXcrlDW+zDcSZV7OWIHBjvQdl16zop192zP
         mpFQ==
X-Gm-Message-State: AOAM530sO86qpTSVtY+m16E038hLxiADRdTctg6BWZUuAbrN7kO7wvPf
        IAbb7BJPDqY6IgYG6Sq1gQo/OITLbUiD7hG5
X-Google-Smtp-Source: ABdhPJzsdlMHRxyos3uF4hHJJelrZ7btwxLKKgAeXOsUK2JeW9y8K9+1SxWDIb5O2qeIBcFgnXut7g==
X-Received: by 2002:a2e:5411:: with SMTP id i17mr312973ljb.97.1632926859999;
        Wed, 29 Sep 2021 07:47:39 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id b15sm9929lji.126.2021.09.29.07.47.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 07:47:38 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id z24so11693406lfu.13
        for <linux-arch@vger.kernel.org>; Wed, 29 Sep 2021 07:47:38 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr309494ljp.494.1632926858377;
 Wed, 29 Sep 2021 07:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Sep 2021 07:47:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
Message-ID: <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Sep 28, 2021 at 2:15 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Introduce the ctrl_dep macro in the generic headers, and use it
> everywhere it appears relevant.

The control dependency is so subtle - just see our discussions - that
I really think every single use of it needs to have a comment about
why it's needed.

Right now, that patch seems to just sprinkle them more or less
randomly. That's absolutely not what I want. It will just mean that
other people start sprinkling them randomly even more, and nobody will
dare remove them.

So I'd literally want a comment about "this needs a control
dependency, because otherwise the compiler could merge the two
identical stores X and Y".

When you have a READ_ONCE() in the conditional, and a WRITE_ONCE() in
the statement protected by the conditional, there is *no* need to
randomly sprinkle noise that doesn't matter.

And if there *is* need ("look, we have that same store in both the if-
and the else-statement" or whatever), then say so, and state that
thing.

               Linus

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B05F39C059
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jun 2021 21:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbhFDTWD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Jun 2021 15:22:03 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:44024 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbhFDTWD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Jun 2021 15:22:03 -0400
Received: by mail-lj1-f174.google.com with SMTP id w15so12875627ljo.10
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 12:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EyRvp1Le9j8ZjSEQazCeGMLQ42i99SaZFsOsJn9QM9I=;
        b=EFA8lMXiHBSq1dsiYMglygqx4CgloOEOXJtJ7wOE2XEc/t799BU2wssV18vK1QVykb
         N5m/kaGAIK6/8vPFgK33FPSW0AO7mleVxmFFPR86Vc6dayz+cvyiOGmfDv0sXk0dvLwa
         9ZKMQSlGztBR3jKI7oxQbnJFCI/E5MCf7IJRg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EyRvp1Le9j8ZjSEQazCeGMLQ42i99SaZFsOsJn9QM9I=;
        b=B3xJcGsdNzUj1d4crl5aPEwsX7/wTANdByY9kgT1BlK6eikxphvFu//xaq7dOCMZLI
         OPyrB/DK3BANUIE/IFCkVEH95iYPvoNUHw55hObnMmlatevgPbEwInnOUkQSRYAAq9jK
         lH+Yt5LvFRnDYQlQFBILxXDXYYCL645pUOQBzF/WX7nfK+kNvVCK3OA4L3y/1iD+zxP+
         +7xZlrT4hj4nEYjjZORi7ijV7KL72kz5rKHKmR8kvnFD0c7UHw5KnbfmR8Vb2ND967cr
         Jobrt/I5EtQpIyAmu+QDDvRaE8I6+45sMa7C089bnTpJ7nS0qyzC1h1O0JaQoen6LlMp
         nGLw==
X-Gm-Message-State: AOAM533mcqqGga4QKIRjrbPDBjzNoTqFcp/B9tcF0/ZiOgRiVUp5ME5v
        dnXr7xDb7NWnfwZBbNaZmsx0OHWj8AcNfwdockg=
X-Google-Smtp-Source: ABdhPJz9JZ31yNFNPfM4Fb3qwB8OSGfrKUaeu+PGRSF0TbVUVOgSVOvPLjUToIAbyfcHGlIjwiItlQ==
X-Received: by 2002:a05:651c:ca:: with SMTP id 10mr3295524ljr.383.1622834341859;
        Fri, 04 Jun 2021 12:19:01 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id c12sm271206lfd.105.2021.06.04.12.19.00
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jun 2021 12:19:00 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id u22so12893871ljh.7
        for <linux-arch@vger.kernel.org>; Fri, 04 Jun 2021 12:19:00 -0700 (PDT)
X-Received: by 2002:a2e:a443:: with SMTP id v3mr4455147ljn.251.1622834339906;
 Fri, 04 Jun 2021 12:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <YLn8dzbNwvqrqqp5@hirez.programming.kicks-ass.net>
 <20210604104359.GE2318@willie-the-truck> <YLoPJDzlTsvpjFWt@hirez.programming.kicks-ass.net>
 <20210604134422.GA2793@willie-the-truck> <YLoxAOua/qsZXNmY@hirez.programming.kicks-ass.net>
 <20210604151356.GC2793@willie-the-truck> <YLpFHE5Cr45rWTUV@hirez.programming.kicks-ass.net>
 <YLpJ5K6O52o1cAVT@hirez.programming.kicks-ass.net> <20210604155154.GG1676809@rowland.harvard.edu>
 <YLpSEM7sxSmsuc5t@hirez.programming.kicks-ass.net> <20210604182708.GB1688170@rowland.harvard.edu>
 <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
In-Reply-To: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Jun 2021 12:18:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
Message-ID: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Fri, Jun 4, 2021 at 12:09 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Again, semantics do matter, and I don't see how the compiler could
> actually break the fundamental issue of "load->conditional->store is a
> fundamental ordering even without memory barriers because of basic
> causality", because you can't just arbitrarily generate speculative
> stores that would be visible to others.

This, after all, is why we trust that the *hardware* can't do it.

Even if the hardware mis-speculates and goes down the wrong branch,
and speculatively does the store when it shouldn't have, we don't
care: we know that such a speculative store can not possibly become
semantically visible (*) to other threads.

For all the same reasons, I don't see how a compiler can violate
causal ordering of the code (assuming, again, that the test is
_meaningful_ - if we write nonsensical code, that's a different
issue).

If we have compilers that create speculative stores that are visible
to other threads, we need to fix them.

               Linus

(*) By "semantically visible" I intend to avoid the whole timing/cache
pattern kind of non-semantic visibility that is all about the spectre
leakage kind of things.

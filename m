Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 314CF2D34FD
	for <lists+linux-arch@lfdr.de>; Tue,  8 Dec 2020 22:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725766AbgLHVKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Dec 2020 16:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727524AbgLHVKv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 8 Dec 2020 16:10:51 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06924C0617A7
        for <linux-arch@vger.kernel.org>; Tue,  8 Dec 2020 13:10:06 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id e2so5011186pgi.5
        for <linux-arch@vger.kernel.org>; Tue, 08 Dec 2020 13:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JlsOI1fRDP5hh5RRN78La/q8WBPdxUn50gvC+PZHts8=;
        b=P0U7Ogd8zoiY2n175d1X/g+/fJdAmGtiw6Ed5UHTXp8ErBagDDkxCwMTGBF9BCIOjy
         pbq/5qwvvmMeWHqUKqTbcNu+xhFsava13TOOa+wLsx8wIArkRm1a9Ar0K9/Kvv8AKw8K
         wAIbNzDXN/ALgxyANFROrjx2Duw9tqQCdjAO5s/bky5fQ31eeRIzwiwPCCeJ9G21PMfp
         0uSk9B6jy06FghAAJqiXpgYoIS0I+PnwdJ8bmYhf7TSY4IKWk8Dfbpn8T2PQYftvQb0G
         TqVBRNnLA45BlEuMp1qEk5rIQLxsS4U1OGfqsttmRzHkFoLCsLcFH/cjS3FxF+XpxVrk
         VA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JlsOI1fRDP5hh5RRN78La/q8WBPdxUn50gvC+PZHts8=;
        b=PNTYKq8Z/IrYHNdqAs/HHtZX2Dv1tRpSXRt+eZFJ4idwLvqT3xWr2Xvu7Q5bEtLTJK
         cueLE3/8So39f0torN3lyTzoKBWQPDfKEJ+6Kl7VXtUPcGqMxWZaqOO6KZtZjNxzn3O7
         XTGk9b19tiS+XhJwL0lr11OpjKOCN1N9oKYoL8MuVqMRXLg5YDdh2T6RBuwPTFDgOqe+
         Rv0msCj7eDtXL9vSUfrVJrbZUQ07WoVPX7fPi8e9gBioHBkaTKtqd+v5EiEV7g1bqjly
         rfxOYmGQuMvQz85/8TJqeyU6Sv9MBq8feFRp/8mJJUYMPoYzvfy7WsWLlBsYgPeygZKr
         uDzQ==
X-Gm-Message-State: AOAM532tfV4wqm40PyzaKEafO5iKe8Y5meDhVvthijhxCvVUC8AeBvU2
        zA3hEiMOE55H0gKuYG8MflUmGjmg8vptJ8eU7k8tHw==
X-Google-Smtp-Source: ABdhPJyLnu/bEkr1l2p2adVzNhFUDAMWuxSKY6xfqwbS1B4vhRKyNpYWWFzDSp2GEeJ76KAN+nCTPZuawZcHYARPCnA=
X-Received: by 2002:a63:3247:: with SMTP id y68mr4840pgy.10.1607461806350;
 Tue, 08 Dec 2020 13:10:06 -0800 (PST)
MIME-Version: 1.0
References: <20201201213707.541432-1-samitolvanen@google.com>
 <CAK8P3a1WEAo2SEgKUEs3SB7n7QeeHa0=cx_nO==rDK0jjDArow@mail.gmail.com>
 <CABCJKueCHo2RYfx_A21m+=d1gQLR9QsOOxCsHFeicCqyHkb-Kg@mail.gmail.com> <CAK8P3a1Xfpt7QLkvxjtXKcgzcWkS8g9bmxD687+rqjTafTzKrg@mail.gmail.com>
In-Reply-To: <CAK8P3a1Xfpt7QLkvxjtXKcgzcWkS8g9bmxD687+rqjTafTzKrg@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 8 Dec 2020 13:09:54 -0800
Message-ID: <CAKwvOd=hL=Vt1ATYqky9jmv+tM5hpTnLRuZudG-7ki0EYoFGJQ@mail.gmail.com>
Subject: Re: [PATCH v8 00/16] Add support for Clang LTO
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 8, 2020 at 1:00 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Dec 8, 2020 at 5:43 PM 'Sami Tolvanen' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > On Tue, Dec 8, 2020 at 4:15 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > - one build seems to take even longer to link. It's currently at 35GB RAM
> > >   usage and 40 minutes into the final link, but I'm worried it might
> > > not complete
> > >   before it runs out of memory.  I only have 128GB installed, and google-chrome
> > >   uses another 30GB of that, and I'm also doing some other builds in parallel.
> > >   Is there a minimum recommended amount of memory for doing LTO builds?
> >
> > When building arm64 defconfig, the maximum memory usage I measured
> > with ThinLTO was 3.5 GB, and with full LTO 20.3 GB. I haven't measured
> > larger configurations, but I believe LLD can easily consume 3-4x that
> > much with full LTO allyesconfig.
>
> Ok, that's not too bad then. Is there actually a reason to still
> support full-lto
> in your series? As I understand it, full LTO was the initial approach and
> used to work better, but thin LTO is actually what we want to use in the
> long run. Perhaps dropping the full LTO option from your series now
> that thin LTO works well enough and uses less resources would help
> avoid some of the problems.

While all developers agree that ThinLTO is a much more palatable
experience than full LTO; our product teams prefer the excessive build
time and memory high water mark (at build time) costs in exchange for
slightly better performance than ThinLTO in <benchmarks that I've been
told are important>.  Keeping support for full LTO in tree would help
our product teams reduce the amount of out of tree code they have.  As
long as <benchmarks that I've been told are important> help
sell/differentiate phones, I suspect our product teams will continue
to ship full LTO in production.
-- 
Thanks,
~Nick Desaulniers

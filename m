Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B61F569767B
	for <lists+linux-arch@lfdr.de>; Wed, 15 Feb 2023 07:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjBOGhk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Feb 2023 01:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBOGhj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Feb 2023 01:37:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C28F244A9
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 22:37:36 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id fi26so20515329edb.7
        for <linux-arch@vger.kernel.org>; Tue, 14 Feb 2023 22:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SkGPeLz9G3QwJ7k+VnCtMU3iYf1WQRR6SOIzc6kL610=;
        b=S+/FEIEt4gy30WD7pMHIwm4gBOKP21dIzeE16rtGdoMse6JZhBIma9C1lcV1OYwgIu
         r1jOJVEWnKOfuiJ6deWTFg9E2OZxOjOEBClujnGijJKrsnjEvr7HdH7IpoepWZDZoh3G
         gFZGO3THVBdThMTwxwVj54vwrK3rOqz63DdorxFDVNHgLAXhKvoFgzHWGFG9JalNErfv
         3g3UJmFfIC8mn8OBnHqgwBRJxYAPVvFqszDtc08+DPqBxGbaSfW7i2Ar+Uom8gpz1Zgm
         jMZ0v0B4riYMskl5qnxraB7Qu7hQbEUcletQE/G+NrK7fEAvJa3fRXfG5jg7y5v0XKfr
         2yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SkGPeLz9G3QwJ7k+VnCtMU3iYf1WQRR6SOIzc6kL610=;
        b=LxcUlu1YnnLR9mXG6HGw5GuDzNkE/L6W+lbEZNkkghN1NhNcByM2kyXSzDpGmnJLkQ
         kcBPwaod4/plLfrrXq6yG92qYhumfs5bnaagrDptzayUuGDAMFQidMwmifH7lDsXXGx9
         Dtowqp52UbWW12NpXgYb88MXrpa6R1lvpzHBeeAHUIhsOHKoFis3vim91I2Jn85xzmAN
         yT5qxuVQH9A9+IH+hSnRHj4XpyNJPUO9b37xcFtjbjWJFquL9mbMH4xOwCWcSoFK4XIq
         rlZaupKQ97ZKFtjOj91uYXoJJV6lh2sDpZIdiP8z/UfRpg2yNTvb5PdIMCwMCPc9sHo5
         OcNA==
X-Gm-Message-State: AO0yUKWVTCkyOVS/UvSZuFHeiT8teE1W/nVtsfzWrdQ/xouGSWtCLbn9
        IZ2YYrewRsOnr5hNzZuZ/kVl6waeJUH6W8cWOgWHpg==
X-Google-Smtp-Source: AK7set+qXiQiB9x9uCSwZk1QYwnxZY1Eg0UWlqo7Q/oouHLaAgH6SKW5Si30EzW4dwAZHuh6nm4kP34VtzMPlMZwUBk=
X-Received: by 2002:a50:d717:0:b0:4ab:49b9:686d with SMTP id
 t23-20020a50d717000000b004ab49b9686dmr434737edi.1.1676443054782; Tue, 14 Feb
 2023 22:37:34 -0800 (PST)
MIME-Version: 1.0
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-20-rick.p.edgecombe@intel.com> <20230214000947.GB4016181@debug.ba.rivosinc.com>
 <1dd1c61c69739fde6db445df79ebbbbec0efe8cd.camel@intel.com>
 <20230214061007.GC4016181@debug.ba.rivosinc.com> <9ea047ed05d75822991325b709f583ee10b0fa34.camel@intel.com>
In-Reply-To: <9ea047ed05d75822991325b709f583ee10b0fa34.camel@intel.com>
From:   Deepak Gupta <debug@rivosinc.com>
Date:   Tue, 14 Feb 2023 22:37:16 -0800
Message-ID: <CAKC1njST4i=88zqk6kQfjnVjr+eU=hdDYmTJSb_TGrKX9UftjQ@mail.gmail.com>
Subject: Re: [PATCH v5 19/39] mm: Fixup places that call pte_mkwrite() directly
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 14, 2023 at 10:24 AM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> On Mon, 2023-02-13 at 22:10 -0800, Deepak Gupta wrote:
> > On Tue, Feb 14, 2023 at 01:07:24AM +0000, Edgecombe, Rick P wrote:
> > > On Mon, 2023-02-13 at 16:09 -0800, Deepak Gupta wrote:
> > > > Since I've a general question on outcome of discussion of how to
> > > > handle
> > > > `pte_mkwrite`, so I am top posting.
> > > >
> > > > I have posted patches yesterday targeting riscv zisslpcfi
> > > > extension.
> > > >
> > >
> > >
> https://lore.kernel.org/lkml/20230213045351.3945824-1-debug@rivosinc.com/
> > > >
> > > > Since there're similarities in extension(s), patches have
> > > > similarity
> > > > too.
> > > > One of the similarity was updating `maybe_mkwrite`. I was asked
> > > > (by
> > > > dhildenb
> > > > on my patch #11) to look at x86 approach on how to approach this
> > > > so
> > > > that
> > > > core-mm approach fits multiple architectures along with the need
> > > > to
> > > > update `pte_mkwrite` to consume vma flags.
> > > > In x86 CET patch series, I see that locations where `pte_mkwrite`
> > > > is
> > > > invoked are updated to check for shadow stack vma and not
> > > > necessarily
> > > > `pte_mkwrite` itself is updated to consume vma flags. Let me know
> > > > if
> > > > my
> > > > understanding is correct and that's the current direction (to
> > > > update
> > > > call sites for vma check where `pte_mkwrite` is invoked)
> > > >
> > > > Being said that as I've mentioned in my patch series that
> > > > there're
> > > > similarities between x86, arm and now riscv for implementing
> > > > shadow
> > > > stack
> > > > and indirect branch tracking, overall it'll be a good thing if we
> > > > can
> > > > collaborate and come up with common bits.
> > >
> > > Oh interesting. I've made the changes to have pte_mkwrite() take a
> > > VMA.
> > > It seems to work pretty well with the core MM code, but I'm letting
> > > 0-
> > > day chew on it for a bit because it touched so many arch's. I'll
> > > include you when I send it out, hopefully later this week.
> >
> > Thanks.
> > >
> > > From just a quick look, I see some design aspects that have been
> > > problematic on the x86 implementation.
> > >
> > > There was something like PROT_SHADOW_STACK before, but there were
> > > two
> > > problems:
> > > 1. Writable windows while provisioning restore tokens (maybe this
> > > is
> > > just an x86 thing)
> > > 2. Adding guard pages when a shadow stack was mprotect()ed to
> > > change it
> > > from writable to shadow stack. Again this might be an x86 need,
> > > since
> > > it needed to have it writable to add a restore token, and the guard
> > > pages help with security.
> >
> > I've not seen your earlier patch but I am assuming when you say
> > window you
> > mean that shadow stack was open to regular stores (or I may be
> > missing
> > something here)
> >
> > I am wondering if mapping it as shadow stack (instead of having
> > temporary
> > writeable mapping) and using `wruss` was an option to put the token
> > or
> > you wanted to avoid it?
> >
> > And yes on riscv, architecture itself doesn't define token or its
> > format.
> > Since it's RISC, software can define the token format and thus can
> > use
> > either `sspush` or `ssamoswap` to put a token on `shadow stack`
> > virtual
> > memory.
>
> With WRSS a token could be created via software, but x86 shadow stack
> includes instructions to create and switch to tokens in limited ways
> (RSTORSSP, SAVEPREVSSP), where WRSS lets you write anything. These
> other instructions are enough for glibc, except for writing a restore
> token on a brand new shadow stack.
>
> So WRSS is made optional since it weakens the protection of the shadow
> stack. Some apps may prefer to use it to do exotic things, but the
> glibc implementation didn't require it.
>

Yes, I understand WRSS in user mode is not safe and defeat the purpose as well.

I actually had meant why WRUSS couldn't be used in the kernel to
manufacture the token when the kernel
creates the shadow stack while parsing elf bits. But then I went
through you earlier patch series now and I've a
a little bit of context now. There is a lot of history and context
(and mess) here.

> >
> > >
> > > So instead this series creates a map_shadow_stack syscall that maps
> > > a
> > > shadow stack and writes the token from the kernel side. Then
> > > mprotect()
> > > is prevented from making shadow stack's conventionally writable.
> > >
> > > another difference is enabling shadow stack based on elf header
> > > bits
> > > instead of the arch_prctl()s. See the history and reasoning here
> > > (section "Switch Enabling Interface"):
> > >
> > >
> https://lore.kernel.org/lkml/20220130211838.8382-1-rick.p.edgecombe@intel.com/
> > >
> > > Not sure if those two issues would be problems on riscv or not.
> >
> > Apart from mapping and window issue that you mentioned, I couldn't
> > understand on why elf header bit is an issue only in this case for
> > x86
> > shadow stack and not an issue for let's say aarch64. I can see that
> > aarch64 pretty much uses elf header bit for BTI. Eventually indirect
> > branch tracking also needs to be enabled which is analogous to BTI.
>
> Well for one, we had to deal with those old glibc's. But doesn't BTI
> text need to be mapped with a special PROT as well? So it doesn't just
> turn on enforcement automatically if it detects the elf bit.
>
> >
> > BTW eventually riscv binaries plan to use `.riscv.attributes` section
> > in riscv elf binary instead of `.gnu.note.property`. So I am hoping
> > that
> > part will go into arch specific code of elf parsing for riscv and
> > will be
> > contained.
> >
> > >
> > > For sharing the prctl() interface. The other thing is that x86 also
> > > has
> > > this "wrss" instruction that can be enabled with shadow stack. The
> > > current arch_prctl() interface supports both. I'm thinking it's
> > > probably a pretty arch-specific thing.
> >
> > yes ability to perform writes on shadow stack absolutely are
> > prevented on
> > x86. So enabling that should be a arch specific prctl.
> >
> > >
> > > ABI-wise, are you planning to automatically allocate shadow stacks
> > > for
> > > new tasks? If the ABI is completely different it might be best to
> > > not
> > > share user interfaces. But also, I wonder why is it different.
> >
> > Yes as of now planning both:
> > - allocate shadow stack for new task based on elf header
> > - task can create them using `prctls` (from glibc)
> >
> > And yes `fork` will get the all cfi properties (shdow stack and
> > branch tracking)
> > from parent.
>
> Have you looked at a riscv libc implementation yet? For unifying ABI I
> think that might be best interface to target, for app developers. Then
> each arch can implement enough kernel functionality to support libc
> (for example map_shadow_stack).
>
>

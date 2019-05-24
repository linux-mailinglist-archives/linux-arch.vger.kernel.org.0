Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9CD29B8E
	for <lists+linux-arch@lfdr.de>; Fri, 24 May 2019 17:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389927AbfEXPzu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 24 May 2019 11:55:50 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38205 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389902AbfEXPzu (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 24 May 2019 11:55:50 -0400
Received: by mail-io1-f67.google.com with SMTP id x24so8140640ion.5
        for <linux-arch@vger.kernel.org>; Fri, 24 May 2019 08:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uPv8IlVUlBLwszar8g8FSyr6oh1PreAw0BWGgT17m24=;
        b=zN/BTNZn0LZGxpBEPIZhk1wKtEpFPiCHlRTjgucAdR18Pt7sRBKyqapFTzQyhxavY8
         UI9bigXT2uxU4dzlGdUqnTLLuRHADTEv4IoyQ7/Ek/WCrpae8idVHwyoMjHmlZjpV7Tr
         IPs4ocWr8NpRtBoH/MiVU6Unhc7niQvJLstnUwcT1L2llRU6lc/z+UY7XydKUmc8yfDU
         xkXzyzd4CSsL83TThPC29ntfrRnbR4P9DG2ugI8LxnBzULCzYMWMskIiP8AzjoITY8JD
         EDeG+3UWY6QoSErXUeqBr1tlUf1UTppFw8ei2Bp/rbx1c6DsAiAz5h8OASbGc0vpOqAZ
         V1cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uPv8IlVUlBLwszar8g8FSyr6oh1PreAw0BWGgT17m24=;
        b=XLBXS2TzwJFH01ZmrTGB8hn6YhKcYJp0RxF+Ad7JEv2crZpGhVJLSYVbGRauRrHG+L
         wkgzxfylmcZr3wxKn/RpVCBR7QRfj5euY385OzEtDcrJ+u/YIQxA5Iw2UB2mVGJwQEq+
         qXl8M9FydwC0w6mp2T3JpdFg1aRvfCdBeo8wba/XEajQsoYWgPmmgxjT3koFKVLmhuGm
         sRjmN0cwwnWnEcRquEtsKmQrXfi6qh8Yv+2C1nQ2SgU4TS4o+FNCiRwC8VXW9qwxsJoN
         7shuUhlxgoS5gF9ec+bJFj09+uujtV080NzK60GYn6sBtGvEdZ9Dr31oY+SYu+qGknpg
         0l0Q==
X-Gm-Message-State: APjAAAXZtE/BhQC/vaF1YWL6G4rXbdtSHC8/NKUAUgejDl+5TMIez5CK
        Dr9nXcIkMHug0aw7Rk4kCbzZiwlim7x7qrLUfwipyw==
X-Google-Smtp-Source: APXvYqwhm3jEW34q28TbZPmwtVwwgOdDHaEQ/30VOmVViott9njZcxNX77f2A7JMRhUtrAwaC0WF+d0k/un9tP4kEos=
X-Received: by 2002:a05:6602:2109:: with SMTP id x9mr17805156iox.128.1558713348970;
 Fri, 24 May 2019 08:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190522150239.19314-1-ard.biesheuvel@arm.com>
 <293c9d0f-dc14-1413-e4b4-4299f0acfb9e@arm.com> <f2141ee5-d07a-6dd9-47c6-97e8fbdccf34@arm.com>
 <20190523091811.GA26646@fuggles.cambridge.arm.com> <907a9681-cd1d-3326-e3dd-5f6965497720@arm.com>
 <20190524152045.w3syntzp4bb5jb7u@treble>
In-Reply-To: <20190524152045.w3syntzp4bb5jb7u@treble>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 24 May 2019 17:55:37 +0200
Message-ID: <CAKv+Gu9DLf9y2uqTo407gLK3AX3pq+HGFxytsoR9C2zfGdUc-A@mail.gmail.com>
Subject: Re: [PATCH] module/ksymtab: use 64-bit relative reference for target symbol
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, guillaume.gardet@arm.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Jessica Yu <jeyu@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 24 May 2019 at 17:21, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> On Thu, May 23, 2019 at 10:29:39AM +0100, Ard Biesheuvel wrote:
> >
> >
> > On 5/23/19 10:18 AM, Will Deacon wrote:
> > > On Thu, May 23, 2019 at 09:41:40AM +0100, Ard Biesheuvel wrote:
> > > >
> > > >
> > > > On 5/22/19 5:28 PM, Ard Biesheuvel wrote:
> > > > >
> > > > >
> > > > > On 5/22/19 4:02 PM, Ard Biesheuvel wrote:
> > > > > > The following commit
> > > > > >
> > > > > >     7290d5809571 ("module: use relative references for __ksymtab entries")
> > > > > >
> > > > > > updated the ksymtab handling of some KASLR capable architectures
> > > > > > so that ksymtab entries are emitted as pairs of 32-bit relative
> > > > > > references. This reduces the size of the entries, but more
> > > > > > importantly, it gets rid of statically assigned absolute
> > > > > > addresses, which require fixing up at boot time if the kernel
> > > > > > is self relocating (which takes a 24 byte RELA entry for each
> > > > > > member of the ksymtab struct).
> > > > > >
> > > > > > Since ksymtab entries are always part of the same module as the
> > > > > > symbol they export (or of the core kernel), it was assumed at the
> > > > > > time that a 32-bit relative reference is always sufficient to
> > > > > > capture the offset between a ksymtab entry and its target symbol.
> > > > > >
> > > > > > Unfortunately, this is not always true: in the case of per-CPU
> > > > > > variables, a per-CPU variable's base address (which usually differs
> > > > > > from the actual address of any of its per-CPU copies) could be at
> > > > > > an arbitrary offset from the ksymtab entry, and so it may be out
> > > > > > of range for a 32-bit relative reference.
> > > > > >
> > > >
> > > > (Apologies for the 3-act monologue)
> > >
> > > Exposition, development and recapitulation ;)
> > >
> > > > This turns out to be incorrect. The symbol address of per-CPU variables
> > > > exported by modules is always in the vicinity of __per_cpu_start, and so it
> > > > is simply a matter of making sure that the core kernel is in range for
> > > > module ksymtab entries containing 32-bit relative references.
> > > >
> > > > When running the arm64 with kaslr enabled, we currently randomize the module
> > > > space based on the range of ADRP/ADD instruction pairs, which have a -/+ 4
> > > > GB range rather than the -/+ 2 GB range of 32-bit place relative data
> > > > relocations. So we can fix this by simply reducing the randomization window
> > > > to 2 GB.
> > >
> > > Makes sense. Do you see the need for an option to disable PREL relocs
> > > altogether in case somebody wants the additional randomization range?
> > >
> >
> > No, not really. To be honest, I don't think
> > CONFIG_RANDOMIZE_MODULE_REGION_FULL is that useful to begin with, and the
> > only reason we enabled it by default at the time was to ensure that the PLT
> > code got some coverage after we introduced it.
>
> In code, percpu variables are accessed with absolute relocations, right?

No, they are accessed just like ordinary symbols, so PC32 references
on x86 or ADRP/ADD references on arm64 are both quite common.

> Before I read your 3rd act, I was wondering if it would make sense to do
> the same with the ksymtab relocations.
>
> Like if we somehow [ insert much hand waving ] ensured that everybody
> uses EXPORT_PER_CPU_SYMBOL() for percpu symbols instead of just
> EXPORT_SYMBOL() then we could use a different macro to create the
> ksymtab relocations for percpu variables, such that they use absolute
> relocations.
>
> Just an idea.  Maybe the point is moot now.
>

The problem is that we already have four different ksymtab sections:
normal, GPL, future GPL and unused, and adding the orthogonal per-CPU
property to that would double it to 8.

Since the purpose of the place relative ksymtabs applies to the core
kernel only, another thing I contemplated is using a different ksymtab
format between modules and the core kernel, but that is another can of
worms that I'd rather not open.

But it is indeed moot now ...

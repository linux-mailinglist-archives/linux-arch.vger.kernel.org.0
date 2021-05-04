Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38744373232
	for <lists+linux-arch@lfdr.de>; Wed,  5 May 2021 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbhEDWGK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 May 2021 18:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhEDWGJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 May 2021 18:06:09 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698FFC061574
        for <linux-arch@vger.kernel.org>; Tue,  4 May 2021 15:05:12 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id d3-20020a9d29030000b029027e8019067fso9640213otb.13
        for <linux-arch@vger.kernel.org>; Tue, 04 May 2021 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bUX+fmvBWZ7MZX/eB50i8/ErJ0LDxPwc8AG9r8drP3E=;
        b=rbZN4R3LNUElHNoq86nZOXGZrt/77ppLVA7dfYsuZktEgdzL8Z5lVft97a2Qqc81ZT
         HTsioWhoOv0AtxTWxd4ssatl8Xn9rELCa6fX1sOLMWLfQLeBliCQnVAJp55nq1y3iX36
         KfkjpC9xPq/9dipNYt3q0RoPqVsMR2q13awl/8LY2rjuYvQ+0nBxsCAYaIQoWT8IjHIK
         auE4iv8tVmNW/OJ/EhWt3PB5w6rKfdhtNzFjZGaQr8v851k+jQvNzluu6HQDNHt1H0Kx
         TH4qWjPZQs6LZg6T3ynapkrHbZ+tcuxLKk8SSGpMgcqy4+7IKOXveZp534+A2cOv4IdF
         xTyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bUX+fmvBWZ7MZX/eB50i8/ErJ0LDxPwc8AG9r8drP3E=;
        b=A5MCrhOdQmIUHfliWGttuzCJgb3V/0m98fHVBWk2EVPmRlTSTLV5YmsOhi8NlPktRF
         W54PFF7VckQVK19dhjGNpMKV1AYC0yYrDmq5wGcJeCI9l6xitp/Vyk/c/lOv1k79+UW7
         tF2gVwV3fp2wqEivaPjolIRjSci9Jx6u3ha+mOntBKj/3zGTBO22PWXhtgXNjJxzZ57P
         47rzqOO0YWiYbPJLXmJy7MrC/MdO9Ctb77vlRQ7lcNKsh5pp99EXdkj52NTASupFNQ1u
         Cuu9BpkP8g5/TlWnQFtJApfjm20n30ppKAXs/fmFp5Y3c2YYwGrfkyHd05O40laroXk4
         tBCw==
X-Gm-Message-State: AOAM533BdO4Q5KNL9vTP3O1u5vc4prInIwgVtAOWtnFIOx0iLQp0aBhf
        BV7uTsvsIxHtTFs2SegU/ox/thZrEOtpyntaKyM6cg==
X-Google-Smtp-Source: ABdhPJxnW/mCtJ4lEreTQ7KO/p9+Ge0zM6xJ1dL9j6kkun07AsqbTc7or7bVSiCMpy/URBG+MwV8nVlTOvskSlBNnv4=
X-Received: by 2002:a9d:60c8:: with SMTP id b8mr21322801otk.17.1620165911656;
 Tue, 04 May 2021 15:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
 <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
 <m15z031z0a.fsf@fess.ebiederm.org> <YIxVWkT03TqcJLY3@elver.google.com>
 <m1zgxfs7zq.fsf_-_@fess.ebiederm.org> <m1r1irpc5v.fsf@fess.ebiederm.org>
 <CANpmjNNfiSgntiOzgMc5Y41KVAV_3VexdXCMADekbQEqSP3vqQ@mail.gmail.com>
 <m1czuapjpx.fsf@fess.ebiederm.org> <CANpmjNNyifBNdpejc6ofT6+n6FtUw-Cap_z9Z9YCevd7Wf3JYQ@mail.gmail.com>
 <m14kfjh8et.fsf_-_@fess.ebiederm.org> <m1tuni8ano.fsf_-_@fess.ebiederm.org>
In-Reply-To: <m1tuni8ano.fsf_-_@fess.ebiederm.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 5 May 2021 00:05:00 +0200
Message-ID: <CANpmjNM5sYihM_9P5YHx06BooqLDhK96cMHGKaf61nCcoDJBdw@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] signal: sort out si_trapno and si_perf
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Florian Weimer <fweimer@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 4 May 2021 at 23:13, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> This set of changes sorts out the ABI issues with SIGTRAP TRAP_PERF, and
> hopefully will can get merged before any userspace code starts using the
> new ABI.
>
> The big ideas are:
> - Placing the asserts first to prevent unexpected ABI changes
> - si_trapno becomming ordinary fault subfield.
> - struct signalfd_siginfo is almost full
>
> This set of changes starts out with Marco's static_assert changes and
> additional one of my own that enforces the fact that the alignment of
> siginfo_t is also part of the ABI.  Together these build time
> checks verify there are no unexpected ABI changes in the changes
> that follow.
>
> The field si_trapno is changed to become an ordinary extension of the
> _sigfault member of siginfo.
>
> The code is refactored a bit and then si_perf_type is added along side
> si_perf_data in the _perf subfield of _sigfault of siginfo_t.
>
> Finally the signalfd_siginfo fields are removed as they appear to be
> filling up the structure without userspace actually being able to use
> them.
>
> v2: https://lkml.kernel.org/r/m14kfjh8et.fsf_-_@fess.ebiederm.org
> v1: https://lkml.kernel.org/r/m1zgxfs7zq.fsf_-_@fess.ebiederm.org
>
> Eric W. Biederman (9):
>       signal: Verify the alignment and size of siginfo_t
>       siginfo: Move si_trapno inside the union inside _si_fault
>       signal: Implement SIL_FAULT_TRAPNO
>       signal: Use dedicated helpers to send signals with si_trapno set
>       signal: Remove __ARCH_SI_TRAPNO
>       signal: Rename SIL_PERF_EVENT SIL_FAULT_PERF_EVENT for consistency
>       signal: Factor force_sig_perf out of perf_sigtrap
>       signal: Deliver all of the siginfo perf data in _perf
>       signalfd: Remove SIL_FAULT_PERF_EVENT fields from signalfd_siginfo
>
> Marco Elver (3):
>       sparc64: Add compile-time asserts for siginfo_t offsets
>       arm: Add compile-time asserts for siginfo_t offsets
>       arm64: Add compile-time asserts for siginfo_t offsets

I can't seem to see the rest of them in my inbox. LKML also is missing
them: https://lore.kernel.org/linux-api/m1tuni8ano.fsf_-_@fess.ebiederm.org/

Something must have swallowed them. Could you resend?
I'll then test in the morning.

Thanks,
-- Marco

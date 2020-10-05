Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38907284202
	for <lists+linux-arch@lfdr.de>; Mon,  5 Oct 2020 23:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729750AbgJEVRp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Oct 2020 17:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725795AbgJEVRo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Oct 2020 17:17:44 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C250C0613CE;
        Mon,  5 Oct 2020 14:17:43 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id m11so4503492otk.13;
        Mon, 05 Oct 2020 14:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyrdjCdnHrdnldaqzFTSI9iGwYW5D1gYzC8h8Hdh80E=;
        b=hFgY9RJ2qsAss5wIW2AxUadyOfAnf6CQjsgCVefWPsCZqqELm7merCDWGa1rybmzr6
         8w/zsCZT2umo8TaaFDLvQJELkr6QJQO8W/QpUSXjtQiI2LdLFz6qOD21uPf1FAWIhvyu
         IsiMJRbHlKpm2YrTfdHLzBa4NGXolkXO7iA4cGG5dSUnxV9KEusz2DjMbPW/+Y4HGuLH
         0m6D059Odxk7jRY8v+1edojV4DH1kVJO5vuV5FSQle4DK0/szSJ5Euq4ZJ4BYD8Wny7s
         5KZ90jwQ/4IbVzEhHegzBagh8JdzK3hH09kJjNV0LREIe2P8XSOeuPX+oLvzipE0rUaY
         4W2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyrdjCdnHrdnldaqzFTSI9iGwYW5D1gYzC8h8Hdh80E=;
        b=lz+Hz/2GjVao67DboC/ZGFiGO55cyUlQOD/dr72Ws2AxwYz0mI5nwJWukDHoLghvQQ
         2KqiKiDav2ZwFybXj9JVp1V1ceD/cxyJPT1ulENgBQ45Nh2AEt1axeHtwgjBzI6rKavp
         OoL5zyDVDGHukM5Qcf8NH4EzsetsMAzFd+jbLQHG/466x+ucfHDAHm597+bXQH010uDb
         pzWAl8VTluTFT6i8i8TCAkoYzKebUYy/bw6KTSgX7liICvKvjPKS9lVewFaWLc4anhrr
         WyURgkmMREaDIhZlwVCcxkTyWFi9ormrWwNDZ6ZPzlCTI994+4M1G9e5tfWfIgi6rQKs
         UBHA==
X-Gm-Message-State: AOAM530yxDqWT1C7Umy4K5HkTogRYHsiRdHbJxNzfMkvsY3mTRRMpcSO
        sQN5G2/cpqAHsuEIdIwsAPuz4zI6o/9QU8abqhU=
X-Google-Smtp-Source: ABdhPJwsw1a1+5vVblSv5qH5DSnI+PjKy8oR+ovdmUsJkjIp8Zb5VId6ArhnL/Vpg4zMKTCYJeDQKOpsUSVTyu76Klw=
X-Received: by 2002:a9d:5545:: with SMTP id h5mr807618oti.269.1601932662759;
 Mon, 05 Oct 2020 14:17:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200929205746.6763-1-chang.seok.bae@intel.com> <20201005134534.GT6642@arm.com>
In-Reply-To: <20201005134534.GT6642@arm.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Mon, 5 Oct 2020 14:17:06 -0700
Message-ID: <CAMe9rOpZm43aDG3UJeaioU32zSYdTxQ=ZyZuSS4u0zjbs9RoKw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] x86: Improve Minimum Alternate Stack Size
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Andy Lutomirski <luto@kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Len Brown <len.brown@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 5, 2020 at 6:45 AM Dave Martin <Dave.Martin@arm.com> wrote:
>
> On Tue, Sep 29, 2020 at 01:57:42PM -0700, Chang S. Bae wrote:
> > During signal entry, the kernel pushes data onto the normal userspace
> > stack. On x86, the data pushed onto the user stack includes XSAVE state,
> > which has grown over time as new features and larger registers have been
> > added to the architecture.
> >
> > MINSIGSTKSZ is a constant provided in the kernel signal.h headers and
> > typically distributed in lib-dev(el) packages, e.g. [1]. Its value is
> > compiled into programs and is part of the user/kernel ABI. The MINSIGSTKSZ
> > constant indicates to userspace how much data the kernel expects to push on
> > the user stack, [2][3].
> >
> > However, this constant is much too small and does not reflect recent
> > additions to the architecture. For instance, when AVX-512 states are in
> > use, the signal frame size can be 3.5KB while MINSIGSTKSZ remains 2KB.
> >
> > The bug report [4] explains this as an ABI issue. The small MINSIGSTKSZ can
> > cause user stack overflow when delivering a signal.
> >
> > In this series, we suggest a couple of things:
> > 1. Provide a variable minimum stack size to userspace, as a similar
> >    approach to [5]
> > 2. Avoid using a too-small alternate stack
>
> I can't comment on the x86 specifics, but the approach followed in this
> series does seem consistent with the way arm64 populates
> AT_MINSIGSTKSZ.
>
> I need to dig up my glibc hacks for providing a sysconf interface to
> this...

Here is my proposal for glibc:

https://sourceware.org/pipermail/libc-alpha/2020-September/118098.html

1. Define SIGSTKSZ and MINSIGSTKSZ to 64KB.
2. Add _SC_RSVD_SIG_STACK_SIZE for signal stack size reserved by the kernel.
3. Deprecate SIGSTKSZ and MINSIGSTKSZ if _SC_RSVD_SIG_STACK_SIZE
is in use.


-- 
H.J.

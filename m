Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9099136F148
	for <lists+linux-arch@lfdr.de>; Thu, 29 Apr 2021 22:49:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233664AbhD2UuI (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Apr 2021 16:50:08 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:54623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhD2UuG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Apr 2021 16:50:06 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N4yyQ-1lUlMv1UpQ-010wy8; Thu, 29 Apr 2021 22:49:17 +0200
Received: by mail-wm1-f41.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so521816wmv.1;
        Thu, 29 Apr 2021 13:49:17 -0700 (PDT)
X-Gm-Message-State: AOAM533Lsa8YXw7vetbN82yaMhNUIX/cxsJQ3o0zJumPSHkeUDH4ZlrO
        E2NdMfX1mGTztpCj5Y3ak1IEvnDZGYHfo9QU+VU=
X-Google-Smtp-Source: ABdhPJwlxMNdSsRwR0fdPNqNypLLItyjoOqUJmBY9r3HaMsASmwKpwt6rd7DUEn1wPswZS5VmrYEijB1isok1r6KSGg=
X-Received: by 2002:a7b:c4da:: with SMTP id g26mr2183043wmk.43.1619729356972;
 Thu, 29 Apr 2021 13:49:16 -0700 (PDT)
MIME-Version: 1.0
References: <YIpkvGrBFGlB5vNj@elver.google.com> <m11rat9f85.fsf@fess.ebiederm.org>
In-Reply-To: <m11rat9f85.fsf@fess.ebiederm.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 29 Apr 2021 22:48:40 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
Message-ID: <CAK8P3a0+uKYwL1NhY6Hvtieghba2hKYGD6hcKx5n8=4Gtt+pHA@mail.gmail.com>
Subject: Re: siginfo_t ABI break on sparc64 from si_addr_lsb move 3y ago
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Marco Elver <elver@google.com>,
        Florian Weimer <fweimer@redhat.com>,
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
X-Provags-ID: V03:K1:Y5+kRV9UPqKJX/D/7aStG7U/Py7dIw+sGe7g3Wp8tNykx536WRq
 iv7bhZcLn7MPQIK+Gsjut2r2Itj6RnUpzjoS5iGld/vCXEhrGh/Df0y2laAfdIIVWqQjYsF
 qJI0oQN0aJfc67ZCbPr2aLvhIAp+UGPF3D9E0vMbh/JrPrLq+vGNDfq5TQtBp+fTWKRYaCR
 rOsFCo+6OdKTmhFtRMwow==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0gnD6TDUOGU=:VQyZMBvfQy1PO9+fgiyh4r
 ueF8VvNBMmTBRRaDtlb+077rlOEFzdMgDjMwS8Okn2sDCgz5IB1TForHNfA5k5lhFjLK0S7sa
 BxWimh/mdubIO40EmLhbOs2XjMv1rr4YzC2flihFITSBaO5rL9M1fldhPs0zLjfveHNV63g1D
 BB5XqARpRCbi81hm89Yn56Qy0c3NWBA/6SZBrw0KaUjiQGPY3F3j5bozH7lhroDbXOEbW8l0W
 +cklcRFYePQw18i4fS0Z9l5WohNFS21H3x5xVSZuaerf1tDra5KIZDBQyN0SBga36FYnO55Gp
 RC1JrkceZDDqfYOMmRjkWp5jRdcN9CsCDOlwZyZTnzOoSW/OpgbIMYl5CurgWd0ugiETJDykW
 x93WVKNNyY8jyryfbqgyUdBjfpQHpPFnTbvlBkn8hsZyuMnTPj+XWRDHdZ9SF7fez1BWkcHb6
 Y3rBRdFmnueYn6OdAW+QeId4qwhnyb5NNmxUUa9H0Nw/qb65slp5VdjlBYnAqNTeX+mT6Vkpl
 P0p7x9WVPIkywSg84RUSk0=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 29, 2021 at 7:23 PM Eric W. Biederman <ebiederm@xmission.com> wrote:

> > Which option do you prefer? Are there better options?
>
> Personally the most important thing to have is a single definition
> shared by all architectures so that we consolidate testing.
>
> A little piece of me cries a little whenever I see how badly we
> implemented the POSIX design.  As specified by POSIX the fields can be
> place in siginfo such that 32bit and 64bit share a common definition.
> Unfortunately we did not addpadding after si_addr on 32bit to
> accommodate a 64bit si_addr.
>
> I find it unfortunate that we are adding yet another definition that
> requires translation between 32bit and 64bit, but I am glad
> that at least the translation is not architecture specific.  That common
> definition is what has allowed this potential issue to be caught
> and that makes me very happy to see.
>
> Let's go with Option 3.
>
> Confirm BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR are not
> in use on any architecture that defines __ARCH_SI_TRAPNO, and then fixup
> the userspace definitions of these fields.
>
> To the kernel I would add some BUILD_BUG_ON's to whatever the best
> maintained architecture (sparc64?) that implements __ARCH_SI_TRAPNO just
> to confirm we don't create future regressions by accident.
>
> I did a quick search and the architectures that define __ARCH_SI_TRAPNO
> are sparc, mips, and alpha.  All have 64bit implementations.

I think you (slightly) misread: mips has "#undef __ARCH_SI_TRAPNO", not
"#define __ARCH_SI_TRAPNO". This means it's only sparc and
alpha.

I can see that the alpha instance was added to the kernel during linux-2.5,
but never made it into the glibc or uclibc copy of the struct definition, and
musl doesn't support alpha or sparc. Debian codesearch only turns up
sparc (and BSD) references to si_trapno.

> I did a quick search and the architectures that define __ARCH_SI_TRAPNO
> are sparc, mips, and alpha.  All have 64bit implementations.  A further
> quick search shows that none of those architectures have faults that
> use BUS_MCEERR_AR, BUS_MCEERR_AO, SEGV_BNDERR, SEGV_PKUERR, nor do
> they appear to use mm/memory-failure.c
>
> So it doesn't look like we have an ABI regression to fix.

Even better!

So if sparc is the only user of _trapno and it uses none of the later
fields in _sigfault, I wonder if we could take even more liberty at
trying to have a slightly saner definition. Can you think of anything that
might break if we put _trapno inside of the union along with _perf
and _addr_lsb?

I suppose in theory sparc64 or alpha might start using the other
fields in the future, and an application might be compiled against
mismatched headers, but that is unlikely and is already broken
with the current headers.

       Arnd

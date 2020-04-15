Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2BD71AB0F8
	for <lists+linux-arch@lfdr.de>; Wed, 15 Apr 2020 21:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411749AbgDOTHs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Apr 2020 15:07:48 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:49263 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1416846AbgDOSmf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Apr 2020 14:42:35 -0400
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mcpz0-1ipBG73Ht4-00ZvLZ; Wed, 15 Apr 2020 20:42:33 +0200
Received: by mail-qk1-f177.google.com with SMTP id j4so18440163qkc.11;
        Wed, 15 Apr 2020 11:42:33 -0700 (PDT)
X-Gm-Message-State: AGi0PuYYGv5YSLiGK59bdjApYzeoeRCEyBYw9gvO0T3PRSve31WOUrj+
        tEAsp2ywfNclTKmOWoIWZzshMmJOm44VgNhd/ac=
X-Google-Smtp-Source: APiQypIZI3O2p1q4q+8s5Y9SNBauG7Cht4mJENn5T9Wnb7I1L7mfg4xYofW01eLwovwdOixd1cZYkDTm+fpmobGPva8=
X-Received: by 2002:a37:9d08:: with SMTP id g8mr20477861qke.138.1586976152547;
 Wed, 15 Apr 2020 11:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200415165218.20251-1-will@kernel.org> <20200415165218.20251-6-will@kernel.org>
 <20200415172813.GA2272@lakrids.cambridge.arm.com>
In-Reply-To: <20200415172813.GA2272@lakrids.cambridge.arm.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 15 Apr 2020 20:42:16 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0x10bCQMC=iGm+fU2G1Vc=Zo-4yjaX4Jwso6rgazVzYw@mail.gmail.com>
Message-ID: <CAK8P3a0x10bCQMC=iGm+fU2G1Vc=Zo-4yjaX4Jwso6rgazVzYw@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] arm64: csum: Disable KASAN for do_csum()
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:GMxvKbBCgEZ5iGutzOR80DSYRJEKh6VL1hO5QbXAsGjD4zhju1R
 4z9TjSVzTCyvePIDAsjoAVrzjaAFj4T1FaOJFxjd4iE9LkK08Y2aQXyWvz2eUulAnq0oK3m
 h+jx6sIblT4TP43YbXhEizAtx76JeWXQZukB/XzdwT84UsF8MA/OO4P6eyxqm53ipuCCnHD
 UVnOhesPmDQadmV84co3A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:UeZFsemGmeo=:p2LIvRBVIpHQjqasZi7c9P
 IBi8C2nVn+/40xY+0TQTdutYzAx/iIl7v/eg1GeSzckEkcyRJ1RaEM6poWkm2vGjolI/Prxsa
 eFFCkgz7oe4kGQpnPd3X+wRMqk/SMdXZclpByCU7J0hEXM8fkw2WvXTwkKH5ijQg8baR9ajbB
 JHuerCn8ZO7BkkFTep7ZE0Sya7wqlPiH0NCDIvVs0JG2kqGQhvJy9VgBg1/lp6z8ujykTe5hp
 f4V6rR9uoY6+gylsqYCDwWLHB9ENdprK0bPFJg2y6DUC+7G44VIcanl2NWMMkWVPYEtGgrsxD
 G0D/pi88WLv6HFBaLPFV1WOU67yHU6pNeJ01Dxv+ghAIrozpfYGNETIBQq4YiARZY8U0donmM
 Wsv5G5SmVyLVEmkaUlUYxPyUgjC/42pNYFmKtXeRZp6vKBNszmYUQb8dS40YE4YZlJtxO1X/Z
 fI+SD5NBwNu12TJPf2VooiHOQu2IO4a82iw8lWuAtUO9xaS9hxBhGaSCRY0yzeEvNmcsYFnui
 iqNgW1VbQVA8VNmsEqqITtuvTRhjd1QkRb3K/lx4g7NyqGl+JZUHMddYox53Rg7urNYhrDwl/
 E202a7zMCCcY0/77Iimc05AAeCpKX91biROdtP5pyj2darwK+hkA7bZHVljCYdzcbDXnTYxqz
 BmibnQ6j0RecRfwugTWjVWlwANmJzBjWQVAwgNCWZAjfEJLYaRI1+11KfYpLWvrhafYBYy85H
 zH6NgcTugO6t9xYzeoRcwOtK+oTNg0eyU9BoL8CjQjXtjci34zZzSLmKexN4LH/aLESBs9E2r
 22ib2A6e5HpK/CVNPXsT08jbq8gebRqHPZfVcwnoPoMF8UXf1U=
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 15, 2020 at 7:28 PM Mark Rutland <mark.rutland@arm.com> wrote:
>
> Hi Will,
>
> On Wed, Apr 15, 2020 at 05:52:11PM +0100, Will Deacon wrote:
> > do_csum() over-reads the source buffer and therefore abuses
> > READ_ONCE_NOCHECK() to avoid tripping up KASAN. In preparation for
> > READ_ONCE_NOCHECK() becoming a macro, and therefore losing its
> > '__no_sanitize_address' annotation, just annotate do_csum() explicitly
> > and fall back to normal loads.
>
> I'm confused by this. The whole point of READ_ONCE_NOCHECK() is that it
> isn't checked by KASAN, so if that semantic is removed it has no reason
> to exist.
>
> Changing that will break the unwind/stacktrace code across multiple
> architectures. IIRC they use READ_ONCE_NOCHECK() for two reasons:
>
> 1. Races with concurrent modification, as might happen when a thread's
>    stack is corrupted. Allowing the unwinder to bail out after a sanity
>    check means the resulting report is more useful than a KASAN splat in
>    the unwinder. I made the arm64 unwinder robust to this case.
>
> 2. I believe that the frame record itself /might/ be poisoned by KASAN,
>    since it's not meant to be an accessible object at the C langauge
>    level. I could be wrong about this, and would have to check.

I thought the main reason was deadlocks when a READ_ONCE()
is called inside of code that is part of the KASAN handling. If
READ_ONCE() ends up recursively calling itself, the kernel
tends to crash once it overflows its stack.

> I would like to keep the unwinding robust in the first case, even if the
> second case doesn't apply, and I'd prefer to not mark the entirety of
> the unwinding code as unchecked as that's sufficiently large an subtle
> that it could have nasty bugs.
>
> Is there any way we keep something like READ_ONCE_NOCHECK() around even
> if we have to give it reduced functionality relative to READ_ONCE()?
>
> I'm not enirely sure why READ_ONCE_NOCHECK() had to go, so if there's a
> particular pain point I'm happy to take a look.

As I understood, only this particular instance was removed, not all of them.

         Arnd

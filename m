Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6C3C2734
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jul 2021 18:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbhGIQDB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 9 Jul 2021 12:03:01 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:55757 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbhGIQCz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 9 Jul 2021 12:02:55 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M9Wqa-1m7N6c1xkC-005c7F for <linux-arch@vger.kernel.org>; Fri, 09 Jul 2021
 18:00:10 +0200
Received: by mail-wr1-f53.google.com with SMTP id d2so12858053wrn.0
        for <linux-arch@vger.kernel.org>; Fri, 09 Jul 2021 09:00:10 -0700 (PDT)
X-Gm-Message-State: AOAM531uxdjdrgx/KPFfkLn2TjZL4ZzoKDqWsHCI91OG8YWe58Ev8J1z
        3K5sUOoTZZQmCnZnlpqgw7DqOFLK6rCFY1FwtR0=
X-Google-Smtp-Source: ABdhPJwJMHz+qMlnSRT6OiX05vjkdJtMQE1SrecsCgghAwfOUUkCCIxQHMm11RcYwJuGivR5LVpznhOls8jN4xa/jMo=
X-Received: by 2002:a5d:6485:: with SMTP id o5mr43724729wri.286.1625846409370;
 Fri, 09 Jul 2021 09:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210706041820.1536502-1-chenhuacai@loongson.cn>
 <20210706041820.1536502-11-chenhuacai@loongson.cn> <CAK8P3a0zkiFrn9K14Hg8C-rfCk-GbyTGMnq_DFBd8o28q99tRg@mail.gmail.com>
 <CAAhV-H4WtGqgYF_zDhaS9+Ja7k=Zs8O2qWo5GqHDDf5cKw-zow@mail.gmail.com>
 <CAK8P3a1GQ=P-kNB5+wUkyqV0uD11uHCJZSQ7gbkwjev0GhuJTQ@mail.gmail.com>
 <CAAhV-H4Yqo090vmy0Y7hGzguP9Q_C+EuZvsq7D43dA=J0f_1qA@mail.gmail.com>
 <CAK8P3a0QYcKaCSt9gfvDxDYOhBywihba+wWozspzytssmkx3tw@mail.gmail.com> <875yxjee55.fsf@disp2133>
In-Reply-To: <875yxjee55.fsf@disp2133>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 9 Jul 2021 17:59:53 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1Dp7kiAqJJjTN_dxX_P-VO8+4Macrw3w-E-fGfU-XejQ@mail.gmail.com>
Message-ID: <CAK8P3a1Dp7kiAqJJjTN_dxX_P-VO8+4Macrw3w-E-fGfU-XejQ@mail.gmail.com>
Subject: Re: [PATCH 10/19] LoongArch: Add signal handling support
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Huacai Chen <chenhuacai@gmail.com>, yili0568@gmail.com,
        Huacai Chen <chenhuacai@loongson.cn>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:UKK/dMBUzafL/8YqW/gTmmkyzlI/pmluKoMucEntczwn8lF/a5I
 iOZtuLBIste7rwFBc93e/KjDb39MYN3lWg1nVyW+jEEioUHomuBIJflrvazTp9jd9E6OaRl
 P6pk/LjmlS3ZlPFqhqUNCphKPDYNxi41WnZWnQCid07nYmEtiVs8QWfCx5WhpLvEAQmIaP1
 IMhEQ20vmjkXPRAdRckJA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0w3J5tFh9Fs=:n6jv5CQHfJEobmJ9us7Q4/
 F1zL4npndhEepLzWGgtzvKCWVHK6JowlH8LY2Ww8zRP360bfH6JZwvaCyP7XHUu8j5RwErVpf
 qSLIPZeo6Hcb64SPNJQZU+6CtaFpzZlZg+hQe5/4MVQJ/QEaBxm0Lel+Q2m8LC5kiIXmSc23a
 VneVV+GjtCxJZkNNe4Fic5G6iLt5V7K/SmzUZDxwBBBwJRPqYbO5gBMaQib4N+P6LiO+zRJoO
 ds5TlBaxssOa5I6Y2Yo4OExKN6L4nKtxVT8rQlxrx7paZGazF2siceNs9alvv1LFMOJ+17G6A
 OFn8YHb1HzOG/ONaJTZD1ae8oiz17Df0FtFtWPeq7P+E1LsrvAiP45KBP0WChK8P6VGCe5iCH
 be+X+et6Rmy4gGY+F24wHXVFNgkV1CzFoSoFHFenq51ACKrJzQYD7oqfg9pruTVOFLOD7ewkk
 H5PfQNvxXakF6JzZWrulJ7HUqsyD+xxN55dHsYvCMUt56YWA5L+MzgCT8yFw13A+Ur01i3Tow
 VNsoTtSXuaH4macSsZgnJV1nJcHe+m8hhfGycmzK5TnipXw/dAP9T/fuhdZ2JRPrc40diPEXI
 RK9bdo9kdek1F7PMipG1nyfIeqM2clQbj8Fy7p9lLoUQhJgQugYIe0G3lkVOuJPazIHKZTTrp
 6Mdn+YBJAS0f8V59ojTw28RSzAae0X+rfLPCTSBLqUXNIdXrmR3dXLhvHOj/7seu1MOwBYCGU
 /oTRXwDZcW8JaypCtH7PJLcqQOcxio2Na6ax8WV91osTSrxmP1Tu+ML2P/WQ/Gfz13iIopOtz
 CPCoS2bpWu5XO0BE2xYZISrNLQc5CFlWg2uWVOgybZk7I52p5YHZyQ9hEtRImRjqwnSJs5D5l
 9NV3FaYk68FmohZ5giAuHNYn3nu9VMbena9U7foupoNud/H3ZLYR6wbAznlot3hgPQGG/tb8D
 sw4IOLaoKBgRxjNd9iz6M145yy49KdTvpg/N1U4VJYtoIP7ej7xMf
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 9, 2021 at 4:49 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> > On Fri, Jul 9, 2021 at 11:24 AM Huacai Chen <chenhuacai@gmail.com> wrote:
> >> On Thu, Jul 8, 2021 at 9:30 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > Most such system calls currently go through set_user_sigmask or
> > set_compat_user_sigmask, which only differ on big-endian.
> > I would actually like to see these merged together and have a single
> > helper checking for in_compat_syscall() to decide whether to do
> > the word-swap for 32-bit bit-endian tasks or not, but that's a separate
> > discussion (and I suspect that Eric won't like that version, based on
> > other discussions we've had).
>
> Reading through get_compat_sigset is the best argument I have ever seen
> for getting rid of big endian architectures.  My gut reaction is we
> should just sweep all of the big endian craziness into a corner and let
> it disappear as the big endian architectures are retired.

A nice thought, but not going to happen any time soon as long as IBM
makes money from s390.

> Perhaps we generalize the non-compat version of the system calls and
> only have a compat version of the system call for the big endian
> architectures.
>
> I really hope loongarch and any new architectures added to the tree all
> are little endian.

It is. Most of the architectures merged over the last years only support
little-endian kernels, even those that can theoretically do both in hardware
(c-sky, riscv). arm64 and arc support big-endian in theory, but this is
rarely used.

Most of the server and workstation class hardware from the last
century is big-endian though. OpenRISC was the last architecture
we support that is big-endian only, but this was designed 21 years
ago now.

> > What I think you need for loongarch though is to change
> > set_user_sigmask(), get_compat_sigset() and similar functions to
> > behave differently depending on the user space execution context,
> > converting the 64-bit masks for loongarch/x86/arm64 tasks into
> > 128-bit in-kernel masks, while copying the 128-bit mips masks
> > as-is. This also requires changing the sigset_t and _NSIG
> > definitions so you get a 64-bit mask in user space, but a 128-bit
> > mask in kernel space.
> >
> > There are multiple ways of achieving this, either by generalizing
> > the common code, or by providing an architecture specific
> > implementation to replace it for loongarch only. I think you need to
> > try out which of those is the most maintainable.
>
> I believe all of the modern versions of the system calls that
> take a sigset_t in the kernel also take a sigsetsize.  So the most
> straight forward thing to do is to carefully define what happens
> to sigsets that are too big or too small when set.
>
> Something like defining that if a sigset is larger than the kernel's
> sigset size all of the additional bits must be zero, and if the sigset
> is smaller than the kernel's sigset size all of the missing bits
> will be set to zero in the kernel's sigset_t.  There may be cases
> I am missing bug for SIG_SETMASK, SIG_BLOCK, and SIG_UNBLOCK those
> look like the correct definitions.

Right, that would work as well. It is a change in behavior though,
since currently kernels just reject any non-default sigsetsize, and there
is a chance that this causes problems when some project relies on
being able to pass an arbitrary sigsetsize value, and then someone
tries running this on an older kernel.

> Another option would be to simply have whatever translates the system
> calls in userspace to perform the work of verifying the extra bits in
> the bitmap are unused before calling system calls that take a sigset_t
> and just ignoring the extra bits.

This is why I asked about how the current loongarch code does it.
qemu must already be doing something like this to run mips code on
non-mips architectures or vice-versa. FEX is another project doing
this, but they also want to add support for foreign syscalls (x86 on
arm64 mainly).

Based on previous discussions, I can see us coming up with a more
general way to handle ioctl() commands using some lookup table
to decide which commands need what kind of translation (32-bit
compat, foreign architecture, usercopy, ...). This needs some more
planning and discussion, but if we end up doing it, it would be
plausible to have a more general way for dealing with more than two
ABIs in a syscall.

       Arnd

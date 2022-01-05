Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E192484C28
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 02:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235921AbiAEBhf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 20:37:35 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:47387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiAEBhe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 20:37:34 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1M1HqM-1n7g870vwQ-002pCN; Wed, 05 Jan 2022 02:37:33 +0100
Received: by mail-wm1-f41.google.com with SMTP id l4so24387755wmq.3;
        Tue, 04 Jan 2022 17:37:33 -0800 (PST)
X-Gm-Message-State: AOAM533m75NWqMI6HgX/0YaSqq6cTZp/MyX2XVXahyqxE3yAvN76aqhg
        KNq8vfF3DjVmW6K79t6d9+4srbk2RuYDxo3OYPI=
X-Google-Smtp-Source: ABdhPJxHTEy2C+bjGue39V0EgopuIsgVVGg7KiulqUkwYFCgU2aaR/LD9VtLI0gNzrpuPz9FYmrcnYVs7/LRDERhHMU=
X-Received: by 2002:a1c:7418:: with SMTP id p24mr822472wmc.82.1641346652798;
 Tue, 04 Jan 2022 17:37:32 -0800 (PST)
MIME-Version: 1.0
References: <YdIfz+LMewetSaEB@gmail.com> <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com> <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
 <YdTg3bO6qs0frHVk@gmail.com>
In-Reply-To: <YdTg3bO6qs0frHVk@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jan 2022 20:37:28 -0500
X-Gmail-Original-Message-ID: <CAK8P3a3eFumM0dHkbdqL_1BwEZNRn9x3WxKbWKyapErd3SEEcw@mail.gmail.com>
Message-ID: <CAK8P3a3eFumM0dHkbdqL_1BwEZNRn9x3WxKbWKyapErd3SEEcw@mail.gmail.com>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree -v1:
 Eliminate the Linux kernel's "Dependency Hell"
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:L5CftMAmJz9G1t/eT4THSm4tZDfJSL+6QX3cdze+mFGobaS9Nn2
 cBULP20MnY6QhJ/DYEfMHvWyFxmhd4BCjQwXOTqneXKMIG6v3QV/hzRd7p5QUSNDXPPSEwN
 QaGA1LCkclmq88bjAaRxe+xodNG06Yqk6lbkpFPQv7d/XCYA2dk1bo83ETfS1Uv6dRsXGxD
 13G0MIoYsa4f0k3qw9iPg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:76PQ4h2Jvjo=:afnx2XBKtAF66ZdSil76LK
 L2AIIQsOCSfhR2Qr8+U0UHIVHxgGx/SI3u05unQLOf3GYQbkFU3ao1xsjYgLT8P63d+NrPxFZ
 KOtMrHcd1bp+rnWrxIHFmnjKuE5Qafcn7+mc16ZimVPONYM8s+ZF6KpH2hcW6lcG+A3m8p0gu
 glEOKJ8U4qVdleSuRs/G9jzKa3R629kUuQm2GyLWMON4YZ47j304BKvYfOLQTKSpGhH5X9Mak
 S9Du8wfcZQPLI7jTjdZ0U1uKMCgS7kQVaPLiZ1xALyJkuBhNS9MWj2L5gcz8mhKCF82+k33Dr
 aDjBj/u/UaCx0t6qbdOsluClAbuyWrAuIkcNEZk0EP7lj0bNRz8CWLoizLvYedwTa0GizLLoD
 KQdsUbgg6L201G/ihFVdYXSfkOI7u4YISp6VMjvELS6sYnghWBfQOVX3FgL1eC/CHKQRZozPx
 QlzxzBvi4l5KceI/pYE0jtvs9Y7cGM4xAtpdtK59i9//K/v0z+CWno5hBD/UKWdhhN9gr2S/b
 kPt5ldG7aEGtEwsSA6dYiJ2mLV48NrxCe6YTmXhBmrC/4CKtEj6oMpV4V6a/D2bdqxahlRKE2
 wP+12/YgTwKM4N6ZodiTzQJYquP7mpzTFvvg7sDWDeFbQcemnsUPeDbjIAjjJBWInNSZWJKfV
 LHkTEQiZSg90Cj2vCH9pBks8qQXEqhxku9uBNEr6A8JVh1NztU5kqJZnF/sct6RHS+u0=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 4, 2022 at 7:05 PM Ingo Molnar <mingo@kernel.org> wrote:
> * Arnd Bergmann <arnd@arndb.de> wrote:
>
> > From what I could tell, linux/sched.h was not the only such problem, but
> > I saw similarly bad issues with linux/fs.h (which is what I posted about
> > in November/December), linux/mm.h and linux/netdevice.h on the high
> > level, in low-level headers there are huge issues with linux/atomic.h,
> > linux/mutex.h, linux/pgtable.h etc. I expect that you have addressed
> > these as well,
>
> Correct, each of these was a problem - and a *lot* of other headers in
> addition to those:
>
>   kepler:~/mingo.tip.git> git diff --stat v5.16-rc8.. include/linux/ arch/*/include/asm/ | grep changed
>
>     1335 files changed, 59677 insertions(+), 56582 deletions(-)
>
> and I reduced all the kernels that showed up in the bloat-profile to a
> fraction of their orignal size:
>
>     ------------------------------------------------------------------------------------------
>     | Combined, preprocessed C code size of header, without line markers,
>     | with comments stripped:
>     ------------------------------.-----------------------------.-----------------------------
>                                   | v5.16-rc7                   |  -fast-headers-v1
>                                   |-----------------------------|-----------------------------
>      #include <linux/sched.h>     | LOC: 13,292 | headers:  324 |  LOC:    769 | headers:   64
>      #include <linux/wait.h>      | LOC:  9,369 | headers:  235 |  LOC:    483 | headers:   46
>      #include <linux/rcupdate.h>  | LOC:  8,975 | headers:  224 |  LOC:  1,385 | headers:   86
>      #include <linux/hrtimer.h>   | LOC: 10,861 | headers:  265 |  LOC:    229 | headers:   37
>      #include <linux/fs.h>        | LOC: 22,497 | headers:  427 |  LOC:  1,993 | headers:  120
>      #include <linux/cred.h>      | LOC: 17,257 | headers:  368 |  LOC:  4,830 | headers:  129
>      #include <linux/dcache.h>    | LOC: 10,545 | headers:  253 |  LOC:    858 | headers:   65
>      #include <linux/cgroup.h>    | LOC: 33,518 | headers:  522 |  LOC:  2,477 | headers:  111
>      #include <linux/module.h>    | LOC: 16,948 | headers:  339 |  LOC:  2,239 | headers:  122
>      #include <linux/kobject.h>   | LOC: 15,210 | headers:  318 |  LOC:    799 | headers:   59
>      #include <linux/device.h>    | LOC: 20,505 | headers:  408 |  LOC:  2,131 | headers:  123
>      #include <linux/gfp.h>       | LOC: 13,543 | headers:  303 |  LOC:    181 | headers:   26
>      #include <linux/slab.h>      | LOC: 14,037 | headers:  307 |  LOC:    999 | headers:   74
>      #include <linux/mm.h>        | LOC: 26,727 | headers:  453 |  LOC:  1,855 | headers:  133
>      #include <linux/mmzone.h>    | LOC: 12,755 | headers:  293 |  LOC:    832 | headers:   64
>      #include <linux/swap.h>      | LOC: 38,292 | headers:  559 |  LOC: 11,085 | headers:  294
>      #include <linux/writeback.h> | LOC: 36,481 | headers:  550 |  LOC:  1,566 | headers:   92
>      #include <linux/gfp.h>       | LOC: 13,543 | headers:  303 |  LOC:    181 | headers:   26
>      #include <linux/skbuff.h>    | LOC: 36,130 | headers:  558 |  LOC:  1,209 | headers:   89
>      #include <linux/tcp.h>       | LOC: 60,133 | headers:  725 |  LOC:  3,829 | headers:  153
>      #include <linux/udp.h>       | LOC: 59,411 | headers:  721 |  LOC:  3,236 | headers:  146
>      #include <linux/filter.h>    | LOC: 54,172 | headers:  689 |  LOC:  4,087 | headers:   73
>      #include <linux/interrupt.h> | LOC: 14,085 | headers:  340 |  LOC:  2,629 | headers:  124
>
>      #include <net/sock.h>        | LOC: 58,880 | headers:  715 |  LOC:  1,543 | headers:   98
>
>      #include <asm/processor.h>   | LOC:  7,821 | headers:  204 |  LOC:    618 | headers:   41
>      #include <asm/page.h>        | LOC:  1,540 | headers:   97 |  LOC:  1,193 | headers:   82
>      #include <asm/pgtable.h>     | LOC: 12,949 | headers:  297 |  LOC:  5,742 | headers:  217

Ok, this is roughly the list of headers that I had looked at previously.

> <linux/atomic.h> wasn't a particularly big problem - but it does get
> included everywhere, so I moved the most common atomic_t definition into
> <linux/types.h> (on 64-bit kernels), which allowed a big reduction for the
> majority of cases that don't use the atomic APIs:

Good, I have a patch for the same thing, including moving atomic64_t
and atomic_long_t to linux/types.h there -- I don't think it would be good to
have it in different places on 32-bit architectures.

On arm machines, I found atomic.h to be problematic because it is a large
generated header that depends on the barriers which in turn require other
stuff.

>  #include <linux/atomic.h>               | LOC:    176 | headers:   26
>  #include <linux/atomic_api.h>           | LOC:  2,785 | headers:   52
>
> But <linux/atomic_api.h> is still included in ~75% of .c files, mostly for
> good reasons, because it's a very popular low level API.

These are the x86 numbers, right?

> > but I'd like to make sure that your changes are reasonably complete on
> > arm32 and arm64 to avoid having to do the big cleanup more than once.
>
> I did test ARM64 extensively in terms of build coverage - but not in terms
> of header bloat, and I'm sure more could be done there!

My guess is that each architecture has a couple of dark corners that
require cleaning up before we actually see the benefit of the series.
I'm personally most interested in arm32 and arm64 because that's what
I do my testing on, and I'll try to find those corners. One thing I remember
for arm32 is that there is a nasty dependency for get_current() - >
PAGE_SIZE -> asm/pgtable.h, with pgtable including the world again.
You probably got this one, but any such missing thing can can lead to the
other cleanups not helping that much.

> > My approach to the large mid-level headers is somewhat different: rather
> > than completely avoiding them from getting included, I would like to
> > split up the structure definitions from the inline functions.
>
> That's a big chunk of what the -fast-headers tree does: I've split over 85
> headers into <linux/header_types.h> and <linux/header_api.h>...
>
> I've also split up headers further where needed, in particular mm.h
> required multiple levels of splitting to get the dependencies of the most
> commonly used <linux/mm_types.h> and <linux/mm_api.h> headers under
> control:
>
>   kepler:~/mingo.tip.git> ls -ldt include/linux/mm*api*.h
>   -rw-rw-r-- 1 mingo mingo 77130 Jan  4 13:32 include/linux/mm_api.h
>   -rw-rw-r-- 1 mingo mingo 22227 Jan  4 13:32 include/linux/mmzone_api.h
>   -rw-rw-r-- 1 mingo mingo  6759 Jan  4 13:32 include/linux/mm_api_extra.h
>   -rw-rw-r-- 1 mingo mingo   479 Jan  4 13:31 include/linux/mm_api_exe_file.h
>   -rw-rw-r-- 1 mingo mingo   960 Jan  4 13:31 include/linux/mm_api_truncate.h
>   -rw-rw-r-- 1 mingo mingo  1262 Jan  4 13:31 include/linux/mm_api_kvmalloc.h
>   -rw-rw-r-- 1 mingo mingo   719 Jan  4 13:31 include/linux/mm_api_gate_area.h
>   -rw-rw-r-- 1 mingo mingo  1342 Jan  4 13:31 include/linux/mm_api_kasan.h
>   -rw-rw-r-- 1 mingo mingo  3007 Jan  4 13:31 include/linux/mm_api_tlb_flush.h

Ah, good. That is pretty close to what I had in mind as well, so maybe
we can convince Linus after all. ;-)

> The results are pretty nice:
>
>  # vanilla:
>
>    #include <linux/mm.h>                   | LOC: 26,728 | headers:  453
>
>  # -fast-headers:
>
>    #include <linux/mm.h>                   | LOC:  1,855 | headers:  132  # == mm_types.h
>    #include <linux/mm_types.h>             | LOC:  1,855 | headers:  131
>    #include <linux/mm_api.h>               | LOC:  8,587 | headers:  229
>
> And <linux/mm_api.h> is now included only in about 25% of the .c files - in
> the vanilla kernel the use percentage is over ~90%.
>
> But despite all those reductions, <linux/mm_api.h> is still a header with
> one of the largest cumulative footprints within a (distro) kernel build:
>
>                                                               | stripped lines of code
>                                                               |              _____________________________
>                                                               |             | headers included recursively
>                                                               |             |                _______________________________
>                                                               |             |               | usage in a distro kernel build
>  ____________                                                 |             |               |         _________________________________________
> | header name                                                 |             |               |        | million lines of comment-stripped C code
> |                                                             |             |               |        |
>   #include <linux/spinlock_api.h>                             | LOC:  5,142 | headers:  123 | 10,168 | MLOC:   52.2 | #############
>   #include <linux/device/driver.h>                            | LOC:  4,132 | headers:  169 | 12,306 | MLOC:   50.8 | ############
>   #include <linux/mm_api.h>                                   | LOC:  8,584 | headers:  230 |  5,135 | MLOC:   44.0 | ###########
>   #include <linux/skbuff_api.h>                               | LOC:  8,404 | headers:  190 |  5,065 | MLOC:   42.5 | ##########
>   #include <linux/atomic_api.h>                               | LOC:  2,785 | headers:   52 | 15,282 | MLOC:   42.5 | ##########
>   #include <asm/spinlock.h>                                   | LOC:  4,039 | headers:   83 | 10,168 | MLOC:   41.0 | ##########
>   #include <asm/qrwlock.h>                                    | LOC:  4,039 | headers:   82 | 10,168 | MLOC:   41.0 | ##########
>   #include <asm-generic/qrwlock.h>                            | LOC:  4,039 | headers:   81 | 10,168 | MLOC:   41.0 | ##########
>   #include <linux/page_ref.h>                                 | LOC:  5,397 | headers:  168 |  7,578 | MLOC:   40.8 | ##########
>   #include <asm/qspinlock.h>                                  | LOC:  3,990 | headers:   80 | 10,169 | MLOC:   40.5 | ##########
>   #include <linux/device_types.h>                             | LOC:  2,131 | headers:  122 | 17,424 | MLOC:   37.1 | #########
>   #include <linux/module.h>                                   | LOC:  2,239 | headers:  122 | 16,472 | MLOC:   36.8 | #########
>   #include <net/cfg80211.h>                                   | LOC: 29,004 | headers:  423 |  1,205 | MLOC:   34.9 | ########
>   #include <linux/pci.h>                                      | LOC:  7,092 | headers:  232 |  4,849 | MLOC:   34.3 | ########
>   #include <linux/netdevice_api.h>                            | LOC:  8,434 | headers:  225 |  4,065 | MLOC:   34.2 | ########
>   #include <linux/refcount_api.h>                             | LOC:  3,421 | headers:   87 |  9,776 | MLOC:   33.4 | ########
>
> ( The 'MLOC' footprint estimate is number of usages times
>   preprocessed-stripped-header size. )

This is also the metric that I used in my scripts, except I measured
the preprocessed
size in bytes instead of lines, which should make little difference.

> I've reduced header bloat through three primary angles of attack:
>
>   - reducing number of inclusions
>
>   - reducing header size itself, by type/API splitting & by segmenting
>     headers along API usage frequency
>
>   - decoupling headers from each other
>
> As you can see, fast-headers -v1 is much improved (on x86), but there's
> plenty of work left, such as <net/cfg80211.h>. :-)

Right. I mainly focused on splitting types from the rest, which I think
brings most of the benefits, but taking it further as you did here
helps more.

> > Linus didn't really like my approach,
>
> Yeah, so without having a significant build time speedup I didn't like my
> approach(es) either, which is why I didn't post this tree for a long time. :-)
>
> But the results speak for themselves IMO, and we cannot ignore this: my
> project actually accelerated as I progressed, because the kernel rebuilds,
> especially incremental ones, became faster and faster...
>
> Linux kernel header dependencies need to be simplified.

Agreed. In my 2020 experiments, I managed to get from the point of cleaning
up ~100 headers with very little effect (when everything was still included
through some other header) to cleaning up the next 100 and seeing huge
improvements but also getting discouraged because it started breaking
every driver due to missing indirect includes.

> > but I suspect he'll have similar
> > concerns about your solution for linux/sched.h, especially if we end up
> > applying the same hack to other commonly used structures (sk_buff,
> > mm_struct, super_block) in the end.
>
> So the per_task approach is pretty much unavoidable under the constraint of
> having no runtime overhead, given that task_struct is a historic union of a
> zillion types, where 99% of the users don't actually need to know about
> those types.
>
> ( We could eventually get rid of per_task() as well, by turning complex
>   embedded structs into pointers - but that has runtime overhead due to the
>   indirections, and I tried hard to make this approach runtime-invariant,
>   at least conceptually. )

Would it be possible to have one common task_struct definition that has
all the frequently-accessed fields, plus another larger structure that
embeds the smaller structure plus all the other stuff? I suppose that
would require even larger scale reworks, but it may be a nicer end
result. (again, I have yet to read your patches, so there is probably
an obvious answer why you didn't do this).

          Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A070948473C
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 18:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235902AbiADRwO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 12:52:14 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:45375 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiADRwM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 12:52:12 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1Mo7if-1mcwHx3A6t-00pbYT; Tue, 04 Jan 2022 18:52:10 +0100
Received: by mail-wr1-f47.google.com with SMTP id i22so77719258wrb.13;
        Tue, 04 Jan 2022 09:52:10 -0800 (PST)
X-Gm-Message-State: AOAM533Xaq/dN5RspR7u4blMmt+syCRcqS7vtF7oXBenV3dJuD59ZkIP
        tLKjaD5hrU8EQeCJC9JCb4AyQ0bW3az82AJ4Vb8=
X-Google-Smtp-Source: ABdhPJygcoXdlSo0oycRivZs0eEBsO9AOv959rN79bo0Wm/YZAp96RFkt5Mdy0ey7wu8b3j99e/n9n66hIx1SDBwIQ4=
X-Received: by 2002:a5d:6d0e:: with SMTP id e14mr45146863wrq.407.1641318730354;
 Tue, 04 Jan 2022 09:52:10 -0800 (PST)
MIME-Version: 1.0
References: <YdIfz+LMewetSaEB@gmail.com> <YdLL0kaFhm6rp9NS@kroah.com> <YdLaMvaM9vq4W6f1@gmail.com>
In-Reply-To: <YdLaMvaM9vq4W6f1@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Jan 2022 12:51:56 -0500
X-Gmail-Original-Message-ID: <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
Message-ID: <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree -v1:
 Eliminate the Linux kernel's "Dependency Hell"
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
X-Provags-ID: V03:K1:qRTzS+/kEBhbTFyZMvrFIWz9fWjSV6QXwddBZvvw0dnDNZcYuAe
 cv5fjH3elkHdFzwOcAkwatEm+oA0HtPZ4f8Rftf4O4olDKY7z8sKuLl/znIDh2dvl6w7iIh
 JwdEd5gMh3EynUBDwR0ziJL8FqwQsn2Rcc608Eq9rT1OByPXhy9NosHV8hkucq21f3m3D+Q
 bXfL1fkU9HsYyOagcD3aQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:3U68u6PHqCM=:dPKRX8LVcPTjJdPheCWELg
 gOiFDst0opVaPZlLrE6WOBzXVCTf9UfdIA0p9S3NQKxuppA3P2IKiDWfHEmmSNk4sFyK3K1/w
 i0lCq+kmGCQnzT/swXWr+psDyZMWlk0QrYCFq37Rf/AYClLpbFQnmXEhY7AjszxPZhl2C301H
 vIMuuAIcG+MZN2MNZDCHctQnuh5n8FUcp2kRQswvEf8KOf9baIIZq/tw0+F6RhjsUof2DJjVa
 9JeYdHT7RUwlh2UkCjA6E88yeQqTj96RS/Y8RWWtzqZw2s9270HcqZpuAle4Hn/4ZrxpIHrvG
 MftCV+NgyWETUhWRUj433xQBJKU334kYuS1nT0tLVRLotYbykQsWcnfIdrqR6KSxUdJnZEYm6
 8N/zbFWsgz4xtJOXUiSXjN27KYfV7SvSgYCP/DrZhTQfG9QHQs90GNm16YAFHRPVatFpJ7J7T
 G8wqCdOrBPsDycWKAdn5yWwVTb2HU/Bdzcz+BIbIFZVctlY5ewIbBRY7k6oB6877Y1azlYbCb
 plqtP/A52qbIF6/GXihf3LNYFf6hSvQRLCJcgn6qIU6en/ydmx+8USyxhHzCV8n/TPaMNhAsX
 oS3JkDpBN+HvkuB1oTlnzrpczI31d2WRpoYUD7Gzhcz1jXcyxQMvparTHpuVhXykDoNK9PQq0
 VXQQ8gTiw7GW3GrWOQ0OmOZBa+3SEgXxIokevpdA8DxcKXUW5tSZdv9LMeNsYAwVZitrVE65W
 6c/hBQZ2AOnQGKLGWG5TO7rP/XcpFzi5YpYSWh1lyIPURgjXoKXU9BW+cV5uvWPGD8CgHXAdf
 dhS3urLAXtF7qOgcW6X5YwOeNr2o6tY+WNOfb8/O9nnHOsH1hM=
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 3, 2022 at 6:12 AM Ingo Molnar <mingo@kernel.org> wrote:
> * Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > Before going into details about how this tree solves 'dependency hell'
> > > exactly, here's the current kernel build performance gain with
> > > CONFIG_FAST_HEADERS=y enabled, (and with CONFIG_KALLSYMS_FAST=y enabled as
> > > well - see below), using a stock x86 Linux distribution's .config with all
> > > modules built into the vmlinux:
> > >
> > >   #
> > >   # Performance counter stats for 'make -j96 vmlinux' (3 runs):
> > >   #
> > >   # (Elapsed time in seconds):
> > >   #
> > >
> > >   v5.16-rc7:            231.34 +- 0.60 secs, 15.5 builds/hour    # [ vanilla baseline ]
> > >   -fast-headers-v1:     129.97 +- 0.51 secs, 27.7 builds/hour    # +78.0% improvement
> > >
> > > Or in terms of CPU time utilized:
> > >
> > >   v5.16-rc7:            11,474,982.05 msec cpu-clock   # 49.601 CPUs utilized
> > >   -fast-headers-v1:      7,100,730.37 msec cpu-clock   # 54.635 CPUs utilized   # +61.6% improvement
> >
> > Speed up is very impressive, nice job!
>
> Thanks! :-)

I've done some work in this area in the past, didn't quite take it enough of the
way to get this far. The best I saw was 30% improvement with clang, which
tends to be more sensitive than gcc towards header file bloat, as it does more
detailed syntax checking before eliminating dead code.

Did you try both gcc and clang for this?

> > That issue aside, I took a glance at the tree, and overall it looks like
> > a lot of nice cleanups.  Most of these can probably go through the
> > various subsystem trees, after you split them out, for the "major" .h
> > cleanups.  Is that something you are going to be planning on doing?
>
> Yeah, I absolutely plan on doing that too:
>
> - About ~70% of the commits can be split up & parallelized through
>   maintainer trees.
>
> - With the exception of the untangling of sched.h, per_task and the
>   "Optimize Headers" series, where a lot of patches are dependent on each
>   other. These are actually needed to get any measurable benefits from this
>   tree (!). We can do these through the scheduler tree, or through the
>   dedicated headers tree I posted.
>
> The latter monolithic series is pretty much unavoidable, it's the result of
> 30 years of coupling a lot of kernel subsystems to task_struct via embedded
> structs & other complex types, that needed quite a bit of effort to
> untangle, and that untangling needed to happen in-order.
>
> Do these plans this sound good to you?

I haven't had a chance to look at your tree yet, I'm still on vacation
without access to my normal workstation. I would like to run my own
scripts for analyzing the header dependencies on it after I get back
next week.

From what I could tell, linux/sched.h was not the only such problem,
but I saw similarly bad issues with linux/fs.h (which is what I posted
about in November/December), linux/mm.h and linux/netdevice.h
on the high level, in low-level headers there are huge issues with
linux/atomic.h, linux/mutex.h, linux/pgtable.h etc. I expect that you
have addressed these as well, but I'd like to make sure that your
changes are reasonably complete on arm32 and arm64 to avoid
having to do the big cleanup more than once.

My approach to the large mid-level headers is somewhat different:
rather than completely avoiding them from getting included, I would
like to split up the structure definitions from the inline functions.
Linus didn't really like my approach, but I suspect he'll have similar
concerns about your solution for linux/sched.h, especially if we end
up applying the same hack to other commonly used structures
(sk_buff, mm_struct, super_block) in the end. I should be able to
come up with a less handwavy reply after I've actually studied your
approach better.

Most of the patches should be the same either way (adding back
missing includes to drivers, and doing cleanups to commonly
included headers to avoid the deep nesting), the interesting bit
will be how to properly define the larger structures without pulling
in the rest of the world.

         Arnd

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 449FB484B7A
	for <lists+linux-arch@lfdr.de>; Wed,  5 Jan 2022 01:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236670AbiAEAGH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 19:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbiAEAFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 19:05:55 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0143CC061799;
        Tue,  4 Jan 2022 16:05:54 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id q14so147047590edi.3;
        Tue, 04 Jan 2022 16:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LHCuPc28gpRtTgmUG7Zto5zTMvaXoPqHnTKBsFl65zQ=;
        b=JjPqjcb06i5bYjehZwTsAS9fW4RL3hQkSEvxtSHPW+VA6ZL54kn7TgzsLfY+sEDUC8
         khwBl3QCrvO0+Z0S4E/Q03VA9RsI1NBh9pG7g0dHgEsjhOif2UpzMTuFZWVDLzNwI3NP
         cn/rANsifi1zEoIJOokOYVMCVOg3NtKGOEuOVbewte2gnuwrmeQIO5CSWVqcc5Dsb/y2
         guseZDP4q2HNr3WMrQ25KS+0Cu062af/r9riQ74C2EDtFtibXRqsjg2Ebpr0grcX76TL
         K5gAo0egyA5+877eBxfsJLMO5RM9TUawRVfv2UBu4BysTVK6+OzzYOerq75TN3ojp34D
         giFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=LHCuPc28gpRtTgmUG7Zto5zTMvaXoPqHnTKBsFl65zQ=;
        b=PTD/hjzI0q4Vym9e+l6EV4Eo/hQRNVNkS4Q57o2ciaEpQmMWxh2/68ez67hY2ikl9L
         ECcznwIgCj/AyR1XOx7VvVourcjBiskLsW0BgRGEsCZeiNzLfUM1ag04D/ZJjRqQkn01
         SCZopbkLnfY1sWGzp2zf0rS21jM8rnG8LXJ34nXsajnTEdRrFjUXHmEOiQPr/XVVzohJ
         uPNjy3YMu4szRA1OgLO15zIe8gY+hvGuW6I7p0DRTOwFolnLNODrSvs90/Y3RT4jNZSy
         ljrI7tQU4AHJXFoP3OXSErSsxHEQSyRVj9hEPLRMhhqF9E6sNdbmBCB1DNLyPwlCETDa
         PZwA==
X-Gm-Message-State: AOAM531C9Ag5ipYhY5RdkibMmpkMY8bMY/BTopcNHyuBR9Q621ULD/Jk
        OGKXRXkrfkXCufjzGzYPigo=
X-Google-Smtp-Source: ABdhPJz6XqDpm6+eF5TBPBi5EUqi2CFeP8IR7MmPetLazf6OCO8nI2eDHrextmN45zn30XV35AFMxg==
X-Received: by 2002:a17:906:4e56:: with SMTP id g22mr39438140ejw.567.1641341153579;
        Tue, 04 Jan 2022 16:05:53 -0800 (PST)
Received: from gmail.com ([5.38.241.27])
        by smtp.gmail.com with ESMTPSA id f6sm5745507ejf.69.2022.01.04.16.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 16:05:53 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 5 Jan 2022 01:05:49 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
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
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdTg3bO6qs0frHVk@gmail.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdLL0kaFhm6rp9NS@kroah.com>
 <YdLaMvaM9vq4W6f1@gmail.com>
 <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3Q4faZvgVXoCALXiEn9WTunwZy__TjkiHGRQgtK9Uocw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


* Arnd Bergmann <arnd@arndb.de> wrote:

> From what I could tell, linux/sched.h was not the only such problem, but 
> I saw similarly bad issues with linux/fs.h (which is what I posted about 
> in November/December), linux/mm.h and linux/netdevice.h on the high 
> level, in low-level headers there are huge issues with linux/atomic.h, 
> linux/mutex.h, linux/pgtable.h etc. I expect that you have addressed 
> these as well,

Correct, each of these was a problem - and a *lot* of other headers in 
addition to those:

  kepler:~/mingo.tip.git> git diff --stat v5.16-rc8.. include/linux/ arch/*/include/asm/ | grep changed

    1335 files changed, 59677 insertions(+), 56582 deletions(-)

and I reduced all the kernels that showed up in the bloat-profile to a 
fraction of their orignal size:

    ------------------------------------------------------------------------------------------
    | Combined, preprocessed C code size of header, without line markers,
    | with comments stripped:
    ------------------------------.-----------------------------.-----------------------------
                                  | v5.16-rc7                   |  -fast-headers-v1
                                  |-----------------------------|-----------------------------
     #include <linux/sched.h>     | LOC: 13,292 | headers:  324 |  LOC:    769 | headers:   64
     #include <linux/wait.h>      | LOC:  9,369 | headers:  235 |  LOC:    483 | headers:   46
     #include <linux/rcupdate.h>  | LOC:  8,975 | headers:  224 |  LOC:  1,385 | headers:   86
     #include <linux/hrtimer.h>   | LOC: 10,861 | headers:  265 |  LOC:    229 | headers:   37
     #include <linux/fs.h>        | LOC: 22,497 | headers:  427 |  LOC:  1,993 | headers:  120
     #include <linux/cred.h>      | LOC: 17,257 | headers:  368 |  LOC:  4,830 | headers:  129
     #include <linux/dcache.h>    | LOC: 10,545 | headers:  253 |  LOC:    858 | headers:   65
     #include <linux/cgroup.h>    | LOC: 33,518 | headers:  522 |  LOC:  2,477 | headers:  111
     #include <linux/module.h>    | LOC: 16,948 | headers:  339 |  LOC:  2,239 | headers:  122
     #include <linux/kobject.h>   | LOC: 15,210 | headers:  318 |  LOC:    799 | headers:   59
     #include <linux/device.h>    | LOC: 20,505 | headers:  408 |  LOC:  2,131 | headers:  123
     #include <linux/gfp.h>       | LOC: 13,543 | headers:  303 |  LOC:    181 | headers:   26
     #include <linux/slab.h>      | LOC: 14,037 | headers:  307 |  LOC:    999 | headers:   74
     #include <linux/mm.h>        | LOC: 26,727 | headers:  453 |  LOC:  1,855 | headers:  133
     #include <linux/mmzone.h>    | LOC: 12,755 | headers:  293 |  LOC:    832 | headers:   64
     #include <linux/swap.h>      | LOC: 38,292 | headers:  559 |  LOC: 11,085 | headers:  294
     #include <linux/writeback.h> | LOC: 36,481 | headers:  550 |  LOC:  1,566 | headers:   92
     #include <linux/gfp.h>       | LOC: 13,543 | headers:  303 |  LOC:    181 | headers:   26
     #include <linux/skbuff.h>    | LOC: 36,130 | headers:  558 |  LOC:  1,209 | headers:   89
     #include <linux/tcp.h>       | LOC: 60,133 | headers:  725 |  LOC:  3,829 | headers:  153
     #include <linux/udp.h>       | LOC: 59,411 | headers:  721 |  LOC:  3,236 | headers:  146
     #include <linux/filter.h>    | LOC: 54,172 | headers:  689 |  LOC:  4,087 | headers:   73
     #include <linux/interrupt.h> | LOC: 14,085 | headers:  340 |  LOC:  2,629 | headers:  124

     #include <net/sock.h>        | LOC: 58,880 | headers:  715 |  LOC:  1,543 | headers:   98

     #include <asm/processor.h>   | LOC:  7,821 | headers:  204 |  LOC:    618 | headers:   41
     #include <asm/page.h>        | LOC:  1,540 | headers:   97 |  LOC:  1,193 | headers:   82
     #include <asm/pgtable.h>     | LOC: 12,949 | headers:  297 |  LOC:  5,742 | headers:  217

<linux/atomic.h> wasn't a particularly big problem - but it does get 
included everywhere, so I moved the most common atomic_t definition into 
<linux/types.h> (on 64-bit kernels), which allowed a big reduction for the 
majority of cases that don't use the atomic APIs:

 #include <linux/atomic.h>               | LOC:    176 | headers:   26
 #include <linux/atomic_api.h>           | LOC:  2,785 | headers:   52

But <linux/atomic_api.h> is still included in ~75% of .c files, mostly for 
good reasons, because it's a very popular low level API.

> but I'd like to make sure that your changes are reasonably complete on 
> arm32 and arm64 to avoid having to do the big cleanup more than once.

I did test ARM64 extensively in terms of build coverage - but not in terms 
of header bloat, and I'm sure more could be done there!

> My approach to the large mid-level headers is somewhat different: rather 
> than completely avoiding them from getting included, I would like to 
> split up the structure definitions from the inline functions.

That's a big chunk of what the -fast-headers tree does: I've split over 85 
headers into <linux/header_types.h> and <linux/header_api.h>...

I've also split up headers further where needed, in particular mm.h 
required multiple levels of splitting to get the dependencies of the most 
commonly used <linux/mm_types.h> and <linux/mm_api.h> headers under 
control:

  kepler:~/mingo.tip.git> ls -ldt include/linux/mm*api*.h
  -rw-rw-r-- 1 mingo mingo 77130 Jan  4 13:32 include/linux/mm_api.h
  -rw-rw-r-- 1 mingo mingo 22227 Jan  4 13:32 include/linux/mmzone_api.h
  -rw-rw-r-- 1 mingo mingo  6759 Jan  4 13:32 include/linux/mm_api_extra.h
  -rw-rw-r-- 1 mingo mingo   479 Jan  4 13:31 include/linux/mm_api_exe_file.h
  -rw-rw-r-- 1 mingo mingo   960 Jan  4 13:31 include/linux/mm_api_truncate.h
  -rw-rw-r-- 1 mingo mingo  1262 Jan  4 13:31 include/linux/mm_api_kvmalloc.h
  -rw-rw-r-- 1 mingo mingo   719 Jan  4 13:31 include/linux/mm_api_gate_area.h
  -rw-rw-r-- 1 mingo mingo  1342 Jan  4 13:31 include/linux/mm_api_kasan.h
  -rw-rw-r-- 1 mingo mingo  3007 Jan  4 13:31 include/linux/mm_api_tlb_flush.h

The results are pretty nice:

 # vanilla:

   #include <linux/mm.h>                   | LOC: 26,728 | headers:  453

 # -fast-headers:

   #include <linux/mm.h>                   | LOC:  1,855 | headers:  132  # == mm_types.h
   #include <linux/mm_types.h>             | LOC:  1,855 | headers:  131
   #include <linux/mm_api.h>               | LOC:  8,587 | headers:  229

And <linux/mm_api.h> is now included only in about 25% of the .c files - in 
the vanilla kernel the use percentage is over ~90%.

But despite all those reductions, <linux/mm_api.h> is still a header with 
one of the largest cumulative footprints within a (distro) kernel build:

                                                              | stripped lines of code
                                                              |              _____________________________
                                                              |             | headers included recursively
                                                              |             |                _______________________________
                                                              |             |               | usage in a distro kernel build
 ____________                                                 |             |               |         _________________________________________
| header name                                                 |             |               |        | million lines of comment-stripped C code
|                                                             |             |               |        |
  #include <linux/spinlock_api.h>                             | LOC:  5,142 | headers:  123 | 10,168 | MLOC:   52.2 | #############
  #include <linux/device/driver.h>                            | LOC:  4,132 | headers:  169 | 12,306 | MLOC:   50.8 | ############
  #include <linux/mm_api.h>                                   | LOC:  8,584 | headers:  230 |  5,135 | MLOC:   44.0 | ###########
  #include <linux/skbuff_api.h>                               | LOC:  8,404 | headers:  190 |  5,065 | MLOC:   42.5 | ##########
  #include <linux/atomic_api.h>                               | LOC:  2,785 | headers:   52 | 15,282 | MLOC:   42.5 | ##########
  #include <asm/spinlock.h>                                   | LOC:  4,039 | headers:   83 | 10,168 | MLOC:   41.0 | ##########
  #include <asm/qrwlock.h>                                    | LOC:  4,039 | headers:   82 | 10,168 | MLOC:   41.0 | ##########
  #include <asm-generic/qrwlock.h>                            | LOC:  4,039 | headers:   81 | 10,168 | MLOC:   41.0 | ##########
  #include <linux/page_ref.h>                                 | LOC:  5,397 | headers:  168 |  7,578 | MLOC:   40.8 | ##########
  #include <asm/qspinlock.h>                                  | LOC:  3,990 | headers:   80 | 10,169 | MLOC:   40.5 | ##########
  #include <linux/device_types.h>                             | LOC:  2,131 | headers:  122 | 17,424 | MLOC:   37.1 | #########
  #include <linux/module.h>                                   | LOC:  2,239 | headers:  122 | 16,472 | MLOC:   36.8 | #########
  #include <net/cfg80211.h>                                   | LOC: 29,004 | headers:  423 |  1,205 | MLOC:   34.9 | ########
  #include <linux/pci.h>                                      | LOC:  7,092 | headers:  232 |  4,849 | MLOC:   34.3 | ########
  #include <linux/netdevice_api.h>                            | LOC:  8,434 | headers:  225 |  4,065 | MLOC:   34.2 | ########
  #include <linux/refcount_api.h>                             | LOC:  3,421 | headers:   87 |  9,776 | MLOC:   33.4 | ########

( The 'MLOC' footprint estimate is number of usages times 
  preprocessed-stripped-header size. )

I've reduced header bloat through three primary angles of attack:

  - reducing number of inclusions

  - reducing header size itself, by type/API splitting & by segmenting 
    headers along API usage frequency

  - decoupling headers from each other

As you can see, fast-headers -v1 is much improved (on x86), but there's 
plenty of work left, such as <net/cfg80211.h>. :-)

> Linus didn't really like my approach,

Yeah, so without having a significant build time speedup I didn't like my 
approach(es) either, which is why I didn't post this tree for a long time. :-)

But the results speak for themselves IMO, and we cannot ignore this: my 
project actually accelerated as I progressed, because the kernel rebuilds, 
especially incremental ones, became faster and faster...

Linux kernel header dependencies need to be simplified.

> but I suspect he'll have similar 
> concerns about your solution for linux/sched.h, especially if we end up 
> applying the same hack to other commonly used structures (sk_buff, 
> mm_struct, super_block) in the end.

So the per_task approach is pretty much unavoidable under the constraint of 
having no runtime overhead, given that task_struct is a historic union of a 
zillion types, where 99% of the users don't actually need to know about 
those types.

( We could eventually get rid of per_task() as well, by turning complex 
  embedded structs into pointers - but that has runtime overhead due to the 
  indirections, and I tried hard to make this approach runtime-invariant, 
  at least conceptually. )

The header splitting I've done is fundamentally clean (at least 
aspirationally), mostly done along conceptual boundaries or API families.

It's how we'd have implemented many of those headers if we had a time 
machine and went back 30 years. ;-)

> I should be able to come up with a less handwavy reply after I've 
> actually studied your approach better.

Looking forward to it!

Thanks,

	Ingo

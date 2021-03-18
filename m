Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C2733FDEA
	for <lists+linux-arch@lfdr.de>; Thu, 18 Mar 2021 04:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhCRDvC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Mar 2021 23:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbhCRDvC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 17 Mar 2021 23:51:02 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7566C06174A;
        Wed, 17 Mar 2021 20:51:01 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id j25so2554572pfe.2;
        Wed, 17 Mar 2021 20:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=oCoahlrhSUtHIwZHOSYYJeuob0IXRJw9KR2mtFeePrE=;
        b=tMLLXY51bUClfTr/XNQkSycUEZm10E/pbuuyVoWPTqUi//S/B1fnjC69vZAkadgCkd
         BnofYZaesMdG2cbFL9M5TKs6ZhZN2hA9WhBxYUGz1UYW4VIkexYhuosJpG9kK+s53/4K
         oylSUQb4LS6qcfAYpytvEvT7I9C1EFOW7IAmdVeJhSKsDYV+SuHWb7eJV+aGsj0TgZiE
         Ws/Yy4BKjXcE8CLo+YEinDgkrqh6oi3I+/wD59zGWajj15+VRL7QDYuAWfjNf6XxKSe2
         f+UmAUaYvbAeNZHdqI5qYHYvb0+MuyCkBYQySpPEs4oLVlr8lLwfRyAjG0RziY0HLiuO
         gxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=oCoahlrhSUtHIwZHOSYYJeuob0IXRJw9KR2mtFeePrE=;
        b=aK5cCxPN8pc4Pz9AkMGthksYxN+tdQZxVo8tIfGP/b0yB3EbfaYk2R4g8KgKHmyoUD
         ksZ/jmNoSATdJQ0YlzgWGC9IrD2SmHJRqz5ttnVDK3iHS4LwOj64IbZJ5XTvP6InFGC9
         n+X/gIoowZco7aiAbQaB1Z6qt8KyLRWctTrw6jQgTBhYwfxA9dNB2zYJ6XjKLKn65UZJ
         5X0HTNxErIMd+B6jhBti0JLpFsyxcXxkmkncWDSyu6JvmbcOAkMaZ72EKvh39WIHQaGW
         cenlLt9k1B8bOYt3MJGIlTDyXYbvpnavMNOI7VTCbNYco8CMKf87tIOlsJgWtdJ8cxJ4
         Lzdg==
X-Gm-Message-State: AOAM533M8MVHAZN6zt3V4QMn1cUbGbL7RCkpJflXqk/jthps5O2EtZjY
        4olk1imtgfMcUTOb1ZayAb8=
X-Google-Smtp-Source: ABdhPJwRciX0al7Hy0D4VsTRTJHtdDfgNWGUjlaLSRmUAswSxm52BqbW3s3OOmvM9HeKkMlXXK+5hQ==
X-Received: by 2002:a63:6642:: with SMTP id a63mr5150719pgc.333.1616039461220;
        Wed, 17 Mar 2021 20:51:01 -0700 (PDT)
Received: from localhost ([58.84.78.96])
        by smtp.gmail.com with ESMTPSA id d19sm466620pjs.55.2021.03.17.20.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 20:51:00 -0700 (PDT)
Date:   Thu, 18 Mar 2021 13:50:55 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v13 00/14] huge vmalloc mappings
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Eric Dumazet <eric.dumazet@gmail.com>
References: <20210317062402.533919-1-npiggin@gmail.com>
        <20210317155843.c15e71f966f1e4da508dea04@linux-foundation.org>
In-Reply-To: <20210317155843.c15e71f966f1e4da508dea04@linux-foundation.org>
MIME-Version: 1.0
Message-Id: <1616036421.amjz2efujj.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Excerpts from Andrew Morton's message of March 18, 2021 8:58 am:
> On Wed, 17 Mar 2021 16:23:48 +1000 Nicholas Piggin <npiggin@gmail.com> wr=
ote:
>=20
>>=20
>> *** BLURB HERE ***
>>=20
>=20
> That's really not what it means ;)
=20
Sigh, wasn't having a good yesterday.

> Could we please get a nice description for the [0/n]?  What's it all
> about, what's the benefit, what are potential downsides.
>
> And performance testing results!  Because if it ain't faster, there's
> no point in merging it?
>=20

It's supposed to have a bit of description in patch 13, and has some
performance reuslts in patch 14. Is it better to put a bigger writeup
in 0? I thought that tends to get lost.

I'll write something here to discuss for now, and can fit it into the=20
appropriate place in the series after that.

The kernel virtual mapping layer grew support for mapping memory with >=20
PAGE_SIZE ptes with 0ddab1d2ed664 ("lib/ioremap.c: add huge I/O map=20
capability interfaces"), and implemented support for using those huge
page mappings with ioremap.

According to the submission, the use-case is mapping very large=20
non-volatile memory devices, which could be GB or TB.
https://lore.kernel.org/lkml/1425404664-19675-1-git-send-email-toshi.kani@h=
p.com/
The benefit is said to be in the overhead of maintaining the mapping,
perhaps both in memory overhead and setup / teardown time. Memory
overhead for the mapping with a 4kB page and 8 byte page table is 2GB
per TB of mapping, down to 4MB / TB with 2MB pages.

The same huge page vmap infrastructure can be quite easily adapted and
used for mapping vmalloc memory pages without more complexity for arch
or core vmap code. However unlike ioremap, vmalloc page table overhead=20
is not a real problem, so the advantage to justify this is performance.

Several of the most structures in the kernel (e.g., vfs and network hash=20
tables) are allocated with vmalloc on NUMA machines, in order to=20
distribute access bandwidth over the machine. Mapping these with larger
pages can improve TLB usage significantly, for example this reduces TLB=20
misses by nearly 30x on a `git diff` workload on a 2-node POWER9 (59,800=20
-> 2,100) and reduces CPU cycles by 0.54%, due to vfs hashes being=20
allocated with 2MB pages.

[ Other numbers?
  - The difference is even larger in a guest due to more costly TLB=20
    misses.
  - Eric Dumazet was keen on the network hash performance possibilities.
  - Other archs? Ding was doing x86 testing. ]

The kernel module allocator also uses vmalloc to map module images even=20
on non-NUMA, which can result in high iTLB pressure on highly modular=20
distro type of kernels. This series does not implement huge mappings for=20
modules yet, but it's a step along the way. Rick Edgecombe was looking=20
at that IIRC.

The per-cpu allocator similarly might be able to take advantage of this.
Also on the todo list.

The disadvantages of this I can see are:
* Memory fragmentation can waste some physical memory because it will=20
  attempt to allocate larger pages to fit the required size, rounding up=20
  (once the requested size is >=3D 2MB).
  - I don't see it being a big problem in practice unless some user=20
    crops up that allocates thousands of 2.5MB ranges. We can tewak=20
    heuristics a bit there if needed to reduce peak waste.
* Less granular mappings can make the NUMA distribution less balanced.
  - Similar to the above.
  - Could also allocate all major system hashes with one allocation
    up-front and spread them all across the one block, which should help
    overall NUMA distribution and reduce fragmentation waste.
* Callers might expect something about the underlying allocated pages.
  - Tried to keep the apperance of base PAGE_SIZE pages throughout the=20
    APIs and exposed data structures.
  - Added a VM_NO_HUGE_VMAP flag to hammer troublesome cases with.

- Finally, added a nohugevmalloc boot option to turn it off (independent
  of nohugeiomap).

Is that helpful?

Thanks,
Nick

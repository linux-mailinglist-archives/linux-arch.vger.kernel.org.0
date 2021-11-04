Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD6E4459AB
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 19:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhKDS0z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhKDS0z (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 14:26:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C511AC061714
        for <linux-arch@vger.kernel.org>; Thu,  4 Nov 2021 11:24:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id d21so13717319lfg.7
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 11:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Drjex4BCzZzcGSa43EiuKsRpLjU3tkgoWhiUNLTwnVo=;
        b=Wpkdy3PLtZlZLPOafUHAkxn2EbtLQ6+4fDao3Wao2aWSstJx82EbyxQP8ll6MIXPg1
         bkhSoZCifr84VwVh6HOkCHoRMiy9tRmRKMleLKXGOyaPT8DVrnAKtBDDQYMY+A1P0z/Z
         28zI6P4vDT+a17DZPdhk+JzdfSXH28IVf1Gnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Drjex4BCzZzcGSa43EiuKsRpLjU3tkgoWhiUNLTwnVo=;
        b=XkkGhlgm6rR9YxclIxLRcejjYGbnhe7u1OnljZqvmj1FDy6pGHkZuNOp9bM5KM2c9P
         ddBJ+UDod5dxm0pEwPLtvJMZgzGTc1z8SVZI2jQ+Fefjwj1RqcCjTlcP1HQji64JnM/U
         bvy04zw/AQlSO6P+iygf4sh+awCOJQkjmw0rWL3JN6eqj9j8bCLH8O9apl/U+Nv1ue6R
         tGpz3fmqzS7i4OxsMgeZUJokfAE+UC/TfjLgb3RySgP7+SO+oijU6+/Sz5Dohfjn1flE
         ICkJDHXdbewy5wBNi+LQKRYdPSeTXtqSw2fGz+Xiblrpitg6faFdG2iqGT/b3Nzdetue
         PhQA==
X-Gm-Message-State: AOAM533S3bpyt06wb0sHcsg2SUMj0vU00NOSqQJgQ4KwLDK3++B8/mod
        opmB/ytVMh+zCY0PNyOjDD+NSlKiV2SBnQAW
X-Google-Smtp-Source: ABdhPJz+LE22n8D4mSN1EfXfbsnJbfWPpAU3n4FgcmIisiYEwc/K1RvONtPcryghtoQ7UsOOyqc0ew==
X-Received: by 2002:a05:6512:118a:: with SMTP id g10mr16737705lfr.662.1636050254430;
        Thu, 04 Nov 2021 11:24:14 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id p4sm542327lfg.105.2021.11.04.11.24.12
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 11:24:13 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id h11so11039276ljk.1
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 11:24:12 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr27954480ljp.68.1636050252506;
 Thu, 04 Nov 2021 11:24:12 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org> <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com> <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
 <YYQgvTn2NQdZK2Ku@arm.com>
In-Reply-To: <YYQgvTn2NQdZK2Ku@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 11:23:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjv--WRm9ay-D615xRwe+tUhZSg7dM0h32Rcf5TNMrD1g@mail.gmail.com>
Message-ID: <CAHk-=wjv--WRm9ay-D615xRwe+tUhZSg7dM0h32Rcf5TNMrD1g@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 4, 2021 at 11:04 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> Luckily I don't think we have a (working) SMP system with VIVT caches.
> On UP, looking at arm, for VIVT caches it flushes the D-cache before
> kunmap_local() (arch_kmap_local_pre_unmap()). So any new kmap_local()
> would see the correct data even if it's in a different location.

Ok, good.

Yeah, because kmap_local and SMP really would seem to be a "that can't
work with VIVT".

> We still have VIVT processors supported in the kernel and a few where
> the VIPT cache is aliasing (some ARMv6 CPUs). On these,
> flush_dcache_page() is still used to ensure the user aliases are
> coherent with the kernel one, so it's not just about the I/D-cache
> coherency.

Maybe we could try to split it up and make each function have more
well-defined rules? One of the issues with the flush_dcache thing is
that it's always been so ad-hoc and it's not been hugely clear.

For example, people seem to think it's purely about flushing writes.
But for the virtual aliasing issue and kmap, you may need to flush
purely between reads too - just to make sure that you don't have any
stale contents.

That's why kunmap needs to have some unconditional cache flush thing
for the virtual aliasing issue.

But hey, it's entirely possible that it should *not* have that
"flush_dcache_page()" thing, but something that is private to the
architecture.

So VIVT arm (and whoever else) would continue to do the cache flushing
at kunmap_local time (or kmap - I don't think it matters which one you
do, as long as you make sure there are no stale contents from the
previous use of that address).

And then we'd relegate flush_dcache_page() purely for uses where
somebody modifies the data and wants to make sure it ends up being
coherent with subsequent uses (whether kmap and VIVT or I$/D$
coherency issues)?

> The cachetlb.rst doc states the two cases where flush_dcache_page()
> should be called:
>
> 1. After writing to a page cache page (that's what we need on arm64 for
>    the I-cache).
>
> 2. Before reading from a page cache page and user mappings potentially
>    exist. I think arm32 ensures the D-cache user aliases are coherent
>    with the kernel one (added rmk to confirm).

I think the "kernel cache coherency" matters too. The PTE contents
thing seems relevant if we use kmap for that...

So I do think that the "page cache or user mapping" is not necessarily
the only case.

But personally I consider these situations so broken at a hardware
level that I can't find it in myself to care too deeply.

Because user space with non-coherent I$/D$ should do its own cache
flushing if it does "read()" to modify an executable range - exactly
the same way it has to do it for just doing regular stores to that
range.

It really shouldn't be the kernel that cares at all.

             Linus

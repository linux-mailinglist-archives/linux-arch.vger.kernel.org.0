Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E14457FD
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 18:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhKDRLj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 13:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhKDRLj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 Nov 2021 13:11:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05E1C061714
        for <linux-arch@vger.kernel.org>; Thu,  4 Nov 2021 10:09:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s24so10585601lji.12
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 10:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIdAKVGvDiz7S21vfsZfNX/HjQfNdvj7KzU/69Bh2jM=;
        b=YJJUFo/pYbi0ApIjofC6647X/sUNI5FRCh6UJbMkjE5h8XXM1AhQjQYKLgYPRgN4Lc
         MPT75ZOlo0V8rhSGLZ9F6uoYgRTcZci9kRJdTy9PE2rFwjIu1RtHkx4a3cO71A3mwEkd
         PFsGITNC4DKMJNL7hteWPDG+xShQw0MmY/LgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIdAKVGvDiz7S21vfsZfNX/HjQfNdvj7KzU/69Bh2jM=;
        b=lr2hv3FSI5DN0XQgROszHTp0zn8lpvBRFyEC3ShNPRujUHczz7IoL08uMhhcyh1zgC
         Zz4bJycPuNAvB9/YJs8NB/UeugpJ9JvecTOavOtQwLUdCo2x9jmsFutxgrzc08D7+JfE
         TEF0KLBhzd2IzORgWzGoxqBT1P/FyYsE7zxluq4Mwz9tToGdzo+wr8gCG//+jtThYJDQ
         MbqeuZ0JTi9zaG0JGnR80XHv65KJPCQwmNkCjdmnj79osKUzTA6UoaL0v9G7rMJiAAqf
         PRVcN0sJ95Jx7AmohD4A6fXQx8K4fRnqwKaJ2c9OsWA/d1OIp2SUH2xY0WMH20fyoMAs
         QkSw==
X-Gm-Message-State: AOAM531qwkqTnUm52SPsqlnWCOcLNzx8xBN96KlNCyFIzNNk1PdmotsS
        wVHiZtCM7Hw/OPMLD5Hpjvku6fgk2ZPkzTm8
X-Google-Smtp-Source: ABdhPJzvczry8y7lKcs4EJzc4vYkP/fDVPhx9rIkMtHI7OAyJSNcGixwu4Zyq7Y7MiI9b+/J/oD2hA==
X-Received: by 2002:a2e:8e91:: with SMTP id z17mr3182238ljk.467.1636045737709;
        Thu, 04 Nov 2021 10:08:57 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id b22sm548762ljp.87.2021.11.04.10.08.56
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Nov 2021 10:08:56 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id v15so3539730ljc.0
        for <linux-arch@vger.kernel.org>; Thu, 04 Nov 2021 10:08:56 -0700 (PDT)
X-Received: by 2002:a2e:a7d3:: with SMTP id x19mr27547940ljp.68.1636045736293;
 Thu, 04 Nov 2021 10:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <YYP1lAq46NWzhOf0@casper.infradead.org> <CAHk-=wiKac4t-fOP_3fAf7nETfFLhT3ShmRmBq2J96y6jAr56Q@mail.gmail.com>
 <YYQQPuhVUHqfldDg@arm.com>
In-Reply-To: <YYQQPuhVUHqfldDg@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Nov 2021 10:08:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
Message-ID: <CAHk-=wiDjjL50BBU=i8BFz3Rv5+-pGysEyCD+mcc_K_g0140oQ@mail.gmail.com>
Subject: Re: flush_dcache_page vs kunmap_local
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Nov 4, 2021 at 9:54 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> We do. flush_dcache_page() is not just about virtual caches. On arm32/64
> (and powerpc), even with PIPT-like caches, we use it to flag a page's
> D-cache as no longer clean. Subsequently in set_pte_at(), if the mapping
> is executable, we do the cache maintenance to ensure the I and D caches
> are coherent with each other.

Ugh,. ok, so we have two very different use-cases for that function.

Perhaps more importantly, they have hugely different semantics. For
you, it's about pages that can be mapped executable, so it's only
relevant for mappable pages.

For the traditional broken pure virtual cache case, it's not about
user mappings at all, it's about any data structure that we might have
in highmem.

Of course, I think we got rid of most of the other uses of highmem,
and we no longer put any "normal" kernel data in highmem pages. There
used to be patches that did inodes and things like that in highmem,
and they actually depended on the "cache the virtual address so that
it's always the same" behavior.

> I wouldn't add this call to kmap/kunmap_local(), it would be a slight
> unnecessary overhead (we had a customer complaining about kmap_atomic()
> breaking write-streaming, I think the new kmap_local() solved this
> problem, if in the right context).

kmap_local() ends up being (I think) fundamentally broken for virtual
cache coherency anyway, because two different CPU's can see two
different virtual addresses at the same time for the same page (in
ways that the old kmap interfaces could not).

So maybe the answer is "let's forget about the old virtual cache
coherence issue, and make it purely about the I$ mapping case".

At that point, kmap is irrelevant from a virtual address standpoint
and so it doesn't make much sense to fliush on kunmap - but anybody
who writes to a page still needs that flush_dcache_page() thing.

                 Linus

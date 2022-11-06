Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70DF61E6E6
	for <lists+linux-arch@lfdr.de>; Sun,  6 Nov 2022 23:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKFWf0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Nov 2022 17:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiKFWfZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Nov 2022 17:35:25 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1614A464
        for <linux-arch@vger.kernel.org>; Sun,  6 Nov 2022 14:35:21 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id n186so10501689oih.7
        for <linux-arch@vger.kernel.org>; Sun, 06 Nov 2022 14:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZMovLP0zi5Hy9M5Np2yrgkMh7vSv6N1lqtVs8OK/j6M=;
        b=SFFtpaaFdKF014jghg/vqNT3X4Waz9R9v3wN9nf0iRah92p1UUnQbcxIoHsPXF1RLq
         cK+uyn4DmRxuQl+k0wyeRO+yTDJgIff6MXt4wr6tsRo71fWvG3YluXBbLG+G8JrDK2Mc
         Z6GjqaAaevseb04xMi+8briB+EYfhb4ZaGah4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZMovLP0zi5Hy9M5Np2yrgkMh7vSv6N1lqtVs8OK/j6M=;
        b=lNZ6AeBP/FPPd+99Qw+0E7Ddc5uLewODxSPmZwjo9w9jn+uNqWBFnCNmdZfBST3Bm0
         46TOT4YWZ0ZiencdndTsimsMCnIjSXA1js3bx+qWHYxe5l7h1cCToM38J1YQCEh3BswO
         2ZeJgTRq4d3QzG/p7iLn46RKaDJjVU6d5RJXV2NO7dWycflLh+QAEXeOXgsoj/WMqfuH
         pcU8M0CFN43AD8ncOWHSj6KzCvRtBQl2b7mvX0I7cdb6j9Lan28Xx3hAZqNUXtYsi38v
         u9oLQt4n/9ZkSnoT6lRuM4piQhEBA9hmzw4W/LbjVrseCiYGowJZbcbLMq+qUnUtFxJ0
         KVMA==
X-Gm-Message-State: ACrzQf0u3fpR+oSpuBDCYWrLpC+RT8U3xx9yl8QILZbDqytxEwo/OiMB
        AVKklcLVuyDmYdP1XemH0fel2tiPDgid+A==
X-Google-Smtp-Source: AMsMyM4/Lw8TLs79z3wGfa0d78MQqjsRmvFjziqiW5p8AsMNyZZ4YH01TEm3HTDrNEtinhbvRxLicw==
X-Received: by 2002:a05:6808:10ca:b0:35a:5efc:290c with SMTP id s10-20020a05680810ca00b0035a5efc290cmr7710985ois.245.1667774120534;
        Sun, 06 Nov 2022 14:35:20 -0800 (PST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com. [209.85.210.53])
        by smtp.gmail.com with ESMTPSA id en7-20020a056870078700b0013191fdeb9bsm2288724oab.38.2022.11.06.14.35.19
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 14:35:20 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id j25-20020a056830015900b0066ca2cd96daso2075382otp.10
        for <linux-arch@vger.kernel.org>; Sun, 06 Nov 2022 14:35:19 -0800 (PST)
X-Received: by 2002:a05:6902:1352:b0:6bb:3f4b:9666 with SMTP id
 g18-20020a056902135200b006bb3f4b9666mr42872513ybu.101.1667774108259; Sun, 06
 Nov 2022 14:35:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com> <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
In-Reply-To: <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Nov 2022 14:34:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgvx5sDaOfCTMkVpZ9+-iFCeh5AOML5aJG1EiR0+e1aBQ@mail.gmail.com>
Message-ID: <CAHk-=wgvx5sDaOfCTMkVpZ9+-iFCeh5AOML5aJG1EiR0+e1aBQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Uros Bizjak <ubizjak@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

[ Editing down to just the bare-bones problem cases ]

On Sun, Nov 6, 2022 at 1:06 PM Hugh Dickins <hughd@google.com> wrote:
>
> anon_vma (bad)
> --------------
>
> See folio_lock_anon_vma_read(): folio_mapped() plays a key role in
> establishing the continued validity of an anon_vma.  See comments
> above folio_get_anon_vma(), some by me but most by PeterZ IIRC.
>
> I believe what has happened is that your patchset has, very intentionally,
> kept the page as "folio_mapped" until after free_pgtables() does its
> unlink_anon_vmas(); but that is telling folio_lock_anon_vma_read()
> that the anon_vma is safe to use when actually it has been freed.
> (It looked like a page table when I peeped at it.)
>
> I'm not certain, but I think that you made page_zap_pte_rmap() handle
> anon as well as file, just for the righteous additional simplification;
> but I'm afraid that (without opening a huge anon_vma refcounting can of
> worms) that unification has to be reverted, and anon left to go the
> same old way it did before.

Indeed. I made them separate initially, just because the only case
that mattered for the dirty bit was the file-mapped case.

But then the two functions ended up being basically the identical
function, so I unified them again.

But the anonvma lifetime issue looks very real, and so doing the
"delay rmap only for file mappings" seems sane.

In fact, I wonder if we should delay it only for *dirty* file
mappings, since it doesn't matter for the clean case.

Hmm.

I already threw away my branch (since Andrew picked the patches up),
so a question for Andrew: do you want me to re-do the branch entirely,
or do you want me to just send you an incremental patch?

To make for minimal changes, I'd drop the 're-unification' patch, and
then small updates to the zap_pte_range() code to keep the anon (and
possibly non-dirty) case synchronous.

And btw, this one is interesting: for anonymous (and non-dirty
file-mapped) patches, we actually can end up delaying the final page
free (and the rmap zapping) all the way to "tlb_finish_mmu()".

Normally we still have the vma's all available, but yes,
free_pgtables() can and does happen before the final TLB flush.

The file-mapped dirty case doesn't have that issue - not just because
it doesn't have an anonvma at all, but because it also does that
"force_flush" thing that just measn that the page freeign never gets
delayed that far in the first place.

> mm-unstable (bad)
> -----------------
> Aside from that PageAnon issue, mm-unstable is in an understandably bad
> state because you could not have foreseen my subpages_mapcount addition
> to page_remove_rmap().  page_zap_pte_rmap() now needs to handle the
> PageCompound (but not the "compound") case too.  I rushed you and akpm
> an emergency patch for that on Friday night, but you, let's say, had
> reservations about it.  So I haven't posted it, and while the PageAnon
> issue remains, I think your patchset has to be removed from mm-unstable
> and linux-next anyway.

So I think I'm fine with your patch, I just want to move the memcg
accounting to outside of it.

I can re-do my series on top of mm-unstable, I guess. That's probably
the easiest way to handle this all.

Andrew - can you remove those patches again, and I'll create a new
series for you?

                 Linus

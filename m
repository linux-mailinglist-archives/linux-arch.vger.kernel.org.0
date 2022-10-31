Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED8613D96
	for <lists+linux-arch@lfdr.de>; Mon, 31 Oct 2022 19:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiJaSoD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 31 Oct 2022 14:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJaSoA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 31 Oct 2022 14:44:00 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6861312610
        for <linux-arch@vger.kernel.org>; Mon, 31 Oct 2022 11:43:59 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id e15so4070104qts.1
        for <linux-arch@vger.kernel.org>; Mon, 31 Oct 2022 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8MDdMqA+PAi+rQcUxT63VD0K16N9GGR3HYYtFDBfMVw=;
        b=V0yzX02di+ioCTECBa6GTI2Q+vwFsP75Wt6XTY6EnmXPW1DMzdm0BCHuKjAhCWzlfM
         WwSfx5JDtb8a0MFQPuzlsARO9UpOj3xl5wOOdGbv4bC49+cuF78Jkn12MMDF5g8WnwX5
         xk0LYCe3V9j5PLRsdB0b4mdqqENjXZVS1hLAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8MDdMqA+PAi+rQcUxT63VD0K16N9GGR3HYYtFDBfMVw=;
        b=LE5rvOnB+DB7G2+olDeJfe7iFaNYrME1sZWgXu7YK5PyU/eXdn5OukOZTddWgkWEnm
         F9ruLCLC52MYH48tgjlSE0jUOtj2nmWh8MBUO2TCWBFgrm4OyuW4W/siwD/CRZHc9h9v
         qWgZBaS34BDokbh0qKG5C2SLGdtSB/KUxoz/Hmhl3HNHBi0gMiDSZ7wg1CnZtAFAA0YJ
         QFcTOs0Cceqj6CV9VvmoQYiHInE6vww30cUYaQV/coacdUFgmeZCEMaUqcx7QkKQWwj2
         rggOyvtsmpoBRW0pzYdaROXAKyWhJtZIfuGl6t/LSeVVhTLIYwBhsTjCvf+NQ38sON9V
         ptXw==
X-Gm-Message-State: ACrzQf2ZT8jd1tQ/AynUF3vLaH62k4LTfgvFPKMsyP6vmLw9T4tGYq65
        CAdtgLTFS1RlGXPWXm+snpq5nauzTivvwg==
X-Google-Smtp-Source: AMsMyM714uir7YgS0q+6BjeQ6YilAUktS6fRYUT3+kyEs1Ex6yquGfokSAqBdn185+D5siOPlm2r1A==
X-Received: by 2002:ac8:7d94:0:b0:39c:ed3c:98a3 with SMTP id c20-20020ac87d94000000b0039ced3c98a3mr11941728qtd.628.1667241838271;
        Mon, 31 Oct 2022 11:43:58 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id bj27-20020a05620a191b00b006bb366779a4sm5186129qkb.6.2022.10.31.11.43.57
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:43:57 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id f205so14765697yba.2
        for <linux-arch@vger.kernel.org>; Mon, 31 Oct 2022 11:43:57 -0700 (PDT)
X-Received: by 2002:a81:555:0:b0:36b:2d71:5861 with SMTP id
 82-20020a810555000000b0036b2d715861mr14445929ywf.340.1667241827170; Mon, 31
 Oct 2022 11:43:47 -0700 (PDT)
MIME-Version: 1.0
References: <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com> <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
In-Reply-To: <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Oct 2022 11:43:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
Message-ID: <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
Subject: mm: delay rmap removal until after TLB flush
To:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Jann Horn <jannh@google.com>,
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

Updated subject line, and here's the link to the original discussion
for new people:

    https://lore.kernel.org/all/B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com/

On Mon, Oct 31, 2022 at 10:28 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok. At that point we no longer have the pte or the virtual address, so
> it's not going to be exactly the same debug output.
>
> But I think it ends up being fairly natural to do
>
>         VM_WARN_ON_ONCE_PAGE(page_mapcount(page) < 0, page);
>
> instead, and I've fixed that last patch up to do that.

Ok, so I've got a fixed set of patches based on the feedback from
PeterZ, and also tried to do the s390 updates for this blindly, and
pushed them out into a git branch:

    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?h=mmu_gather-race-fix

If people really want to see the patches in email again, I can do
that, but most of you already have, and the changes are either trivial
fixes or the s390 updates.

For the s390 people that I've now added to the participant list maybe
the git tree is fine - and the fundamental explanation of the problem
is in that top-most commit (with the three preceding commits being
prep-work). Or that link to the thread about this all.

That top-most commit is also where I tried to fix things up for s390
that uses its own non-gathering TLB flush due to
CONFIG_MMU_GATHER_NO_GATHER.

NOTE NOTE NOTE! Unlike my regular git branch, this one may end up
rebased etc for further comments and fixes. So don't consider that
stable, it's still more of an RFC branch.

At a minimum I'll update it with Ack's etc, assuming I get those, and
my s390 changes are entirely untested and probably won't work.

As far as I can tell, s390 doesn't actually *have* the problem that
causes this change, because of its synchronous TLB flush, but it
obviously needs to deal with the change of rmap zapping logic.

Also added a few people who are explicitly listed as being mmu_gather
maintainers. Maybe people saw the discussion on the linux-mm list, but
let's make it explicit.

Do people have any objections to this approach, or other suggestions?

I do *not* consider this critical, so it's a "queue for 6.2" issue for me.

It probably makes most sense to queue in the -MM tree (after the thing
is acked and people agree), but I can keep that branch alive too and
just deal with it all myself as well.

Anybody?

                     Linus

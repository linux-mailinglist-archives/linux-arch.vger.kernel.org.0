Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C3361E624
	for <lists+linux-arch@lfdr.de>; Sun,  6 Nov 2022 22:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiKFVGt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Nov 2022 16:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiKFVGo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 6 Nov 2022 16:06:44 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206AD1146
        for <linux-arch@vger.kernel.org>; Sun,  6 Nov 2022 13:06:43 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id lf15so6519370qvb.9
        for <linux-arch@vger.kernel.org>; Sun, 06 Nov 2022 13:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cl3T2kX2Bn7Po+06v+uWOWk/dmmWwqPlgzeoJMMIkg4=;
        b=L4WRc9bqPUJfTMNZcwjljqyoMcIN/xavYSt5+AYQHkS3OkajRlXtR5qNquUTntDwGx
         q7ywNprAdwKZh9/D3dki+7hdYeiOO+BGEQEB3OJPwmUF4cypJ+RMXt6BPdx7Q4aVs8Yz
         70l/YVWUm3Ve8zW4zVcxwSqC7HETxpdFQ1SqEXO4COgkE9/7k4wXQ3yP9eUC3hPHactE
         rhtxAFHp9AG1/dQtx1FDBLvWEQSrLY7dZydEASeIh0hKA7lJrfCejtKRkAyYc0Hy15yq
         CHxBkrun251NcqSlcKZd9tnkF9V1J4bWXmz58xKPD7ozBok9KKjHnskzLlXEyN5Mdupo
         yBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cl3T2kX2Bn7Po+06v+uWOWk/dmmWwqPlgzeoJMMIkg4=;
        b=BuF942LP+kw8QJ9RmuvSoA39AquDvpv86yU9l836An+y2IcXXUbEGI5AiSQN8vBOdq
         yZ4lZJM9aVm8qfMyHZSvpY7zCfEGzFMeWhT1q9MiMxnmoo1qR763lCXjfRcrVFy/Fn8r
         LZCc3yRtGQgfGjSf1yoyY1qXWBQ4frQQhxKcrhQ/sZAOLNVqhGh+BdwjcfxeHeqTAfKN
         NN5UvwHJoqjA/VawcuqjOwZc+m1xh5jt09UJ4UfzbJNw8xmvI52sLeIx1ntlsgRYXgA9
         bPWXBQKU1qYDoiBcM9X1ISJ55TQJGqn2b16EARnkytddXXIytmqGNyflqGtsFugcjLan
         Ztgw==
X-Gm-Message-State: ACrzQf2++wT8epild7HOyFZgw0tSW7k9qB2GwIZOuZuCO2dfxoNdXAO6
        azjQxeVn3fX+WspRgSzSs90Q5w==
X-Google-Smtp-Source: AMsMyM4htDJKOgJ552p6j/sSb0/rPdPXqXN7JUul7Jq61mENdSqluTd/8U8nG4X8XNE2Z7xt5QKTQQ==
X-Received: by 2002:a05:6214:2b46:b0:4b8:d67a:b060 with SMTP id jy6-20020a0562142b4600b004b8d67ab060mr649014qvb.122.1667768790505;
        Sun, 06 Nov 2022 13:06:30 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m13-20020a05620a290d00b006fa43e139b5sm5253412qkp.59.2022.11.06.13.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 13:06:30 -0800 (PST)
Date:   Sun, 6 Nov 2022 13:06:19 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Johannes Weiner <hannes@cmpxchg.org>,
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
Subject: Re: mm: delay rmap removal until after TLB flush
In-Reply-To: <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
Message-ID: <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com> <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com> <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com> <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com> <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com> <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com> <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
 <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com> <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com> <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Adding Stephen to Cc, for next-20221107 alert.
Adding Johannes to Cc, particularly for lock_page_memcg discussion.

On Fri, 4 Nov 2022, Linus Torvalds wrote:
> On Thu, Nov 3, 2022 at 11:33 PM Alexander Gordeev
> <agordeev@linux.ibm.com> wrote:
> >
> > I rather have a question to the generic part (had to master the code quotting).
> 
> Sure.
> 
> Although now I think the series in in Andrew's -mm tree, or just about
> to get moved in there, so I'm not going to touch my actual branch any
> more.

Linus, we've been exchanging about my mm/rmap.c mods in private mail,
I need to raise some points about your mods here in public mail.

Four topics - munlock (good), anon_vma (bad), mm-unstable (bad),
lock_page_memcg (uncertain).  I'm asking Andrew here to back your
patchset out of mm-unstable for now, until we have its fixes in:
otherwise I'm worried that next-20221107 will waste everyone's time.

munlock (good)
--------------
You've separated out the munlock_vma_page() from the rest of PTE
remove rmap work.  Worried me at first, but I think that's fine:
bundling it into page_remove_rmap() was mainly so that we wouldn't
forget to do it anywhere (and other rmap funcs already took vma arg).

Certainly during development, I had been using page mapcount somewhere
inside munlock_vma_page(), either for optimization or for sanity check,
I forget; but gave up on that as unnecessary complication, and I think
it became impossible with the pagevec; so not an issue now.

If it were my change, I'd certainly do it by changing the name of the
vma arg in page_remove_rmap() from vma to munlock_vma, not doing the
munlock when that is NULL, and avoid the need for duplicating code:
whereas you're very pleased with cutting out the unnecessary stuff
in slimmed-down page_zap_pte_rmap().  Differing tastes (or perhaps
you'll say taste versus no taste).

anon_vma (bad)
--------------
My first reaction to your patchset was, that it wasn't obvious to me
that delaying the decrementation of mapcount is safe: I needed time to
think about it.  But happily, testing saved me from needing much thought.

The first problem, came immediately in the first iteration of my
huge tmpfs kbuild swapping loads, was BUG at mm/migrate.c:1105!
VM_BUG_ON_FOLIO(folio_test_anon(src) && !folio_test_ksm(src) && !anon_vma, src);
Okay, that's interesting but not necessarily fatal, we can very easily
make it a recoverable condition.  I didn't bother to think on that one,
just patched around it.

The second problem was more significant: came after nearly five hours
of load, BUG NULL dereference (address 8) in down_read_trylock() in
rmap_walk_anon(), while kswapd was doing a folio_referenced().

That one goes right to the heart of the matter, and instinct had been
correct to worry about delaying the decrementation of mapcount, that is,
extending the life of page_mapped() or folio_mapped().

See folio_lock_anon_vma_read(): folio_mapped() plays a key role in
establishing the continued validity of an anon_vma.  See comments
above folio_get_anon_vma(), some by me but most by PeterZ IIRC.

I believe what has happened is that your patchset has, very intentionally,
kept the page as "folio_mapped" until after free_pgtables() does its
unlink_anon_vmas(); but that is telling folio_lock_anon_vma_read()
that the anon_vma is safe to use when actually it has been freed.
(It looked like a page table when I peeped at it.)

I'm not certain, but I think that you made page_zap_pte_rmap() handle
anon as well as file, just for the righteous additional simplification;
but I'm afraid that (without opening a huge anon_vma refcounting can of
worms) that unification has to be reverted, and anon left to go the
same old way it did before.

I didn't look into whether reverting one of your patches would achieve
that, I just adjusted the code in zap_pte_range() to go the old way for
PageAnon; and that has been running successfully, hitting neither BUG,
for 15 hours now.

mm-unstable (bad)
-----------------
Aside from that PageAnon issue, mm-unstable is in an understandably bad
state because you could not have foreseen my subpages_mapcount addition
to page_remove_rmap().  page_zap_pte_rmap() now needs to handle the
PageCompound (but not the "compound") case too.  I rushed you and akpm
an emergency patch for that on Friday night, but you, let's say, had
reservations about it.  So I haven't posted it, and while the PageAnon
issue remains, I think your patchset has to be removed from mm-unstable
and linux-next anyway.

What happens to mm-unstable with page_zap_pte_rmap() not handling
subpages_mapcount?  In my CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y case,
I get a "Bad page state" even before reaching first login after boot,
"page dumped because: nonzero subpages_mapcount".  Yes, I make it
worse for myself by having a BUG() in bad_page(); others will limp
along with more and more of those "Bad page" messages.

lock_page_memcg (uncertain)
---------------------------
Johannes, please help! Linus has got quite upset by lock_page_memcg(),
its calls from mm/rmap.c anyway, and most particularly by the way
in which it is called at the start of page_remove_rmap(), before
anyone's critical atomic_add_negative(), yet its use is to guarantee
the stability of page memcg while doing the stats updates, done only
when atomic_add_negative() says so.

I do have one relevant insight on this.  It (or its antecedents under
other names) date from the days when we did "reparenting" of memcg
charges from an LRU: and in those days the lock_page_memcg() before
mapcount adjustment was vital, to pair with the uses of folio_mapped()
or page_mapped() in mem_cgroup_move_account() - those "mapped" checks
are precisely around the stats which the rmap functions affect.

But nowadays mem_cgroup_move_account() is only called, with page table
lock held, on matching pages found in a task's page table: so its
"mapped" checks are redundant - I've sometimes thought in the past of
removing them, but held back, because I always have the notion (not
hope!) that "reparenting" may one day be brought back from the grave.
I'm too out of touch with memcg to know where that notion stands today.

I've gone through a multiverse of opinions on those lock_page_memcg()s
in the last day: I currently believe that Linus is right, that the
lock_page_memcg()s could and should be moved just before the stats
updates.  But I am not 100% certain of that - is there still some
reason why it's important that the page memcg at the instant of the
critical mapcount transition be kept unchanged until the stats are
updated?  I've tried running scenarios through my mind but given up.

(And note that the answer might be different with Linus's changes
than without them: since he delays the mapcount decrementation
until long after pte was removed and page table lock dropped).

And I do wish that we could settle this lock_page_memcg() question
in an entirely separate patch: as it stands, page_zap_pte_rmap()
gets to benefit from Linus's insight (or not), and all the other rmap
functions carry on with the mis?placed lock_page_memcg() as before.

Let's press Send,
Hugh

Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC4161FF8B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 21:29:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiKGU3n (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 15:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232951AbiKGU3n (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 15:29:43 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC4183A1
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 12:29:41 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id s20so7923932qkg.5
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 12:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmekPIfsDhO/c1VKUUGZV/Wt7GFULF9qq4iGNhwtPaQ=;
        b=WoUgENFw6x+yDkOL6DTJqhHSKthAbh8p3B4djaVfiu1Y1OuAAH5VN0vqEy2WlUru6T
         qBEWcImUuA95okNKVQS17+EvIUay4jWOzyHexqa6/e0Q/rmKyMAQKq5oz9xW/cpg+3BR
         IBAgXFUqMgzbuGwbQH9Ng0QPbzKb63u+5xeN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmekPIfsDhO/c1VKUUGZV/Wt7GFULF9qq4iGNhwtPaQ=;
        b=AxacGuTm3jtaixT++C8jreirx/H76A43UTPok+qLOMAfR0UvyT07DepEqNEEqptMPq
         AX50TlYoqU1q8/XWJ6kLrd0j1AdvK+ghcN45ugH2/Hy9k25lQ+07IvVyycIKrTlFVxMu
         x2UL5EAsSxcP3G1whBKcft58eh5s2uwz1tnoQ41BKH3OqlQV+dC08iiXFex/sePAqAnx
         e3QL+/TeivwnbJ6Y/J3ms7/Yrx3+sh8CJbaLnB4r7w+THeL1W8lETJrSbQVGrJ+HmWEp
         1LqacP2edmZ2k9LMULXgUAsrLl74bqL7rRwrZvurcJBWiQ0kj9M1WwwEefBj/1JYSXVf
         +mLw==
X-Gm-Message-State: ANoB5plE6kXlCeFaNi2Uz9hahqCIHDkwR3Zik3nU5ybx6pYILkRAItJl
        TlCSzhz8Elxk5R6sGJKuM20N/gxGnVodjg==
X-Google-Smtp-Source: AA0mqf67YUGUhbbCvG1FvXMaW7kIA/RXief+1azUA7Lk/ig2ucA4O6M+i06N+Wwpqq24dztUgwI3zw==
X-Received: by 2002:ae9:d8c3:0:b0:6fa:c793:a5fb with SMTP id u186-20020ae9d8c3000000b006fac793a5fbmr6310271qkf.7.1667852980746;
        Mon, 07 Nov 2022 12:29:40 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id i5-20020ac871c5000000b003a494b61e67sm6699747qtp.46.2022.11.07.12.29.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 12:29:38 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-36ad4cf9132so115601077b3.6
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 12:29:38 -0800 (PST)
X-Received: by 2002:a25:bd7:0:b0:6d7:7464:4859 with SMTP id
 206-20020a250bd7000000b006d774644859mr5895133ybl.362.1667852967798; Mon, 07
 Nov 2022 12:29:27 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net> <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <Y2llcRiDLHc2kg/N@cmpxchg.org>
In-Reply-To: <Y2llcRiDLHc2kg/N@cmpxchg.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 12:29:11 -0800
X-Gmail-Original-Message-ID: <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
Message-ID: <CAHk-=whw1Oo0eJ7fFjy_Fus80CM8CnA4Lb5BrrCdot3Rc1ZZRQ@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Hugh Dickins <hughd@google.com>,
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

On Mon, Nov 7, 2022 at 12:07 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> - If we DO want to codify the pte lock requirement, we should just
>   remove the lock_page_memcg() altogether, as it's fully redundant.
>
> I'm leaning toward that second option.

The thing is, that's very much the case we do *not* want.

We need to delay the rmap removal until at least after the TLB flush.
At least for dirty filemapped pages - because the page cleaning needs
to see that they exists as mapped entities until all CPU's have
*actually* dropped them.

Now, we do the TLB flush still under the page table lock, so we could
still then do the rmap removal before dropping the lock.

But it would be much cleaner from the TLB flushing standpoint to delay
it until the page freeing, which ends up being delayed until after the
lock is dropped.

That said, if always doing the rmap removal under the page table lock
means that that memcg lock can just be deleted in that whole path, I
will certainly bow to _that_ simplification instead, and just handle
the dirty pages after the TLB flush but before the page table drop.

              Linus

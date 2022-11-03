Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B75A9618561
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 17:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbiKCQzQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 12:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbiKCQzH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 12:55:07 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C6E09F
        for <linux-arch@vger.kernel.org>; Thu,  3 Nov 2022 09:55:05 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id cn2-20020a056830658200b0066c74617e3dso1327415otb.2
        for <linux-arch@vger.kernel.org>; Thu, 03 Nov 2022 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qFBunyBEOrah4lD4FZnX/dUVHIoDPQeAQMemRAIrS28=;
        b=DcgTC4GNRUJ+jLqwHMrWKkezqjnj33/pc7lu3nI3p3LFiqXOQEaEPQr5QNj7mD4mHR
         CAd27kZiZM6f6R9EGBGiyRQf55N2SN/io3tVSTaWT0mHHeA8T3cuIDCnW9PTW5VZBHSm
         mZTuMvMxjdI8bktfKo8f6t9re4Iux8AmNyEM4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qFBunyBEOrah4lD4FZnX/dUVHIoDPQeAQMemRAIrS28=;
        b=FZ9Ra9ZTK0Wijd2HN38v07tgcvlOnZk7nBAvX+EJix4UC8ataJsPUh/rqDqU3sML7C
         0wz7EgPItB/B8essXF6sXk4NoBl+lbLwaWEH6p1khHoASKNVF404W4LKPeYNbGk2asGx
         pCWWOVuhEiIipd/W+QZ6kZQmuXiKGWfGecOmH6+BpKcJ3I9j338r1L+aAckqY8HBq9vd
         pBOG6H9LbgrvdcybkXBwfSP/PPGzXDLjMLvEvtXI6Rx8EkxzvTZ9QRvKiLa3LNdyJNcU
         fO0EgFUAiIQYr8EeFvzYXT2imHc04aOmXZem8KaaSOvVE4cdG+eU6kg1I8hnyUDJN7ll
         q2kg==
X-Gm-Message-State: ACrzQf3gC8MsvfBeoTSiKV+GBjdlgpC5HIEI3QKVVV+TrLPmuS7JoqW5
        G6yb7tlhzBKrroVeIzPhUpc7Z+fegmCmRA==
X-Google-Smtp-Source: AMsMyM6it0gvap/AhrcJNLB2Lxu5H82rz66bjDjG4rI9QQi43EYr47zCmDe6sh6wp53JjihRpn0RLg==
X-Received: by 2002:a05:6830:1d49:b0:66c:5619:4c62 with SMTP id p9-20020a0568301d4900b0066c56194c62mr10495278oth.182.1667494504767;
        Thu, 03 Nov 2022 09:55:04 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id l4-20020a056830268400b006619295af60sm528891otu.70.2022.11.03.09.55.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:55:04 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso1303509otq.11
        for <linux-arch@vger.kernel.org>; Thu, 03 Nov 2022 09:55:04 -0700 (PDT)
X-Received: by 2002:a05:6902:702:b0:6ca:a588:2904 with SMTP id
 k2-20020a056902070200b006caa5882904mr29621526ybt.571.1667494493431; Thu, 03
 Nov 2022 09:54:53 -0700 (PDT)
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
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com> <4f6d8fb5-6be5-a7a8-de8e-644da66b5a3d@redhat.com>
In-Reply-To: <4f6d8fb5-6be5-a7a8-de8e-644da66b5a3d@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Nov 2022 09:54:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
Message-ID: <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
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

On Thu, Nov 3, 2022 at 2:52 AM David Hildenbrand <david@redhat.com> wrote:
>
> Happy to see that we're still decrementing the mapcount before
> decrementingthe refcount, I was briefly concerned.

Oh, that would have been horribly wrong.

> I was not able to come up quickly with something that would be
> fundamentally wrong here, but devil is in the detail.

So I tried to be very careful.

The biggest change in the whole series (visible in last patch, but
there in the prep-patches too) is how it narrows down some lock
coverage.

Now, that locking didn't *do* anything valid, but I did try to point
it out when it happens - how first the mapcount is decremented outside
the memcg lock (in preparatory patches), and then later on the
__dec_lruvec_page_state() turns into a dec_lruvec_page_state() because
it's then done outside the page table lock.

The locking in the second case did do something - not locking-wise,
but simply the "running under the spinlock means we are not
preemptable without RT".

And in the memcg case it was just plain overly wide lock regions.

None of the other changes should have any real semantic meaning
*apart* from just keeping ->_mapcount elevated slightly longer.

> Some minor things could be improved IMHO (ENCODE_PAGE_BITS naming is
> unfortunate, TLB_ZAP_RMAP could be a __bitwise type, using VM_WARN_ON
> instead of VM_BUG_ON).

That VM_BUG_ON() is a case of "what to do if this ever triggers?" So a
WARN_ON() would be fatal too, it's some seriously bogus stuff to try
to put bits in that won't fit.

It probably should be removed, since the value should always be pretty
much a simple constant. It was more of a "let's be careful with new
code, not for production".

Probably like pretty much all VM_BUG_ON's are - test code that just
got left around.

I considered just getting rid of ENCODE_PAGE_BITS entirely, since
there is only one bit. But it was always "let's keep the option open
for dirty bits etc", so I kept it, but I agree that the name isn't
wonderful.

And in fact I wanted the encoding to really be done by the caller (so
that TLB_ZAP_RMAP wouldn't be a new argument, but the 'page' argument
to __tlb_remove_page_*() would simply be an 'encoded page' pointer,
but that would have caused the patch to be much bigger (and expanded
the s390 side too). Which I didn't want to do.

Long-term that's probably still the right thing to do, including
passing the encoded pointers all the way to
free_pages_and_swap_cache().

Because it's pretty disgusting how it cleans up that array in place
and then does that cast to a new array type, but it is also disgusting
how it traverses that array multiple times (ie
free_pages_and_swap_cache() will just have *another* loop).

But again, those changes would have made the patch bigger, which I
didn't want at this point (and 'release_pages()' would need that
clean-in-place anyway, unless we changed *that* too and made the whole
page encoding be something widely available).

That's also why I then went with that fairly generic
"ENCODE_PAGE_BITS" name. The *use* of it right now is very very
specific to just the TLB gather, and the TLB_ZAP_RMAP bit shows that
in the name. But then I went for a fairly generic "encode extra bits
in the page pointer" name because it felt like it might expand beyond
the initial intentionally small patch in the long run.

So it's a combination of "we might want to expand on this in the
future" and yet also "I really want to keep the changes localized in
this patch".

And the two are kind of inverses of each other, which hopefully
explains the seemingly disparate naming logic.

                 Linus

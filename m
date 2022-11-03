Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2116185CE
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiKCRKw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 13:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbiKCRKg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 13:10:36 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF55167F9
        for <linux-arch@vger.kernel.org>; Thu,  3 Nov 2022 10:09:40 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id z6so1640057qtv.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Nov 2022 10:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JxCfvbb+eoelACSav5gOVJGA8b7JZzX3u9t6lpOqhGc=;
        b=c21oKw15OEDs7jPQQCx5/Q6jAakEjh4QCyHrqDrHmt1tZB5JiHbbDJmM+26GNCOUuA
         n2GMHrJ6v80we2vb5tM+7RBrSn/OgbLvIvKDSypwoGrv+vFeYz+qEx5tgHNFD4SDuMUn
         DyCZcKZmr8k62mDFGein3IhVz7jo4hs0ekZoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxCfvbb+eoelACSav5gOVJGA8b7JZzX3u9t6lpOqhGc=;
        b=rzPhNw8CtU4fZQKfmGep57uoZ8kuU5/zbULSjgwMBTRjfTNkqujJETo45f6Yilkkcv
         D4BHWgoYxhAHSGuql/mMogN/caDsWqmz4rzy0xc7DvdfRbjXWeJUGLbIcSvGBrNtIYRx
         /uv25iXXeul3ReJbcfL8UvZB6et3Wh+YhHMYASjbbQwYV3+YBtK8erp91yK1h1fHeHzY
         tSyV5GMoWonA2glg7MO0e4irR9FJx0L0UZnVg642uG8oj9LpLJje1B220EO2hzEk5o8G
         PxtGRsltgOYtPCX/ZXmQLeSnrwcne6x9oMnWd8jm3M8KA+fcQKOUJr3CQdJuUtpjwYPJ
         QvCA==
X-Gm-Message-State: ACrzQf2Us207vtGzT0NndvFEj5Mzlch4Jbby5fWeqaZ+2TguxGs3xz7i
        o9eLPXOrIdbVRwJT7p9xxI6YiBolnLxUjA==
X-Google-Smtp-Source: AMsMyM7X/IZRCCWq0/Mea7knSNC2gZZ3DkfLr13aE9n0eE4zlqk7OVKp+YR4etvea0FjzMzfsNsLzw==
X-Received: by 2002:ac8:454d:0:b0:3a5:3623:36f3 with SMTP id z13-20020ac8454d000000b003a5362336f3mr14062631qtn.66.1667495379250;
        Thu, 03 Nov 2022 10:09:39 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id k7-20020ac81407000000b0039cd4d87aacsm826651qtj.15.2022.11.03.10.09.38
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 10:09:38 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id r3so3003569yba.5
        for <linux-arch@vger.kernel.org>; Thu, 03 Nov 2022 10:09:38 -0700 (PDT)
X-Received: by 2002:a25:5389:0:b0:6bc:f12c:5d36 with SMTP id
 h131-20020a255389000000b006bcf12c5d36mr29702771ybb.184.1667495367212; Thu, 03
 Nov 2022 10:09:27 -0700 (PDT)
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
 <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
 <4f6d8fb5-6be5-a7a8-de8e-644da66b5a3d@redhat.com> <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
In-Reply-To: <CAHk-=wiDg_1up8K4PhK4+kzPN7xJG297=nw+tvgrGn7aVgZdqw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Nov 2022 10:09:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgReY6koZTKT97NsCczzr4uYAA66iePv=S_RL-_D-9mmQ@mail.gmail.com>
Message-ID: <CAHk-=wgReY6koZTKT97NsCczzr4uYAA66iePv=S_RL-_D-9mmQ@mail.gmail.com>
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

On Thu, Nov 3, 2022 at 9:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But again, those changes would have made the patch bigger, which I
> didn't want at this point (and 'release_pages()' would need that
> clean-in-place anyway, unless we changed *that* too and made the whole
> page encoding be something widely available).

And just to clarify: this is not just me trying to expand the reach of my patch.

I'd suggest people look at mlock_pagevec(), and realize that LRU_PAGE
and NEW_PAGE are both *exactly* the same kind of "encoded_page" bits
that TLB_ZAP_RMAP is.

Except the mlock code does *not* show that in the type system, and
instead just passes a "struct page **" array around in pvec->pages,
and then you'd just better know that "oh, it's not *really* just a
page pointer".

So I really think that the "array of encoded page pointers" thing is a
generic notion that we *already* have.

It's just that we've done it disgustingly in the past, and I didn't
want to do that disgusting thing again.

So I would hope that the nasty things that the mlock code would some
day use the same page pointer encoding logic to actually make the
whole "this is not a page pointer that you can use directly, it has
low bits set for flags" very explicit.

I am *not* sure if then the actual encoded bits would be unified.
Probably not - you might have very different and distinct uses of the
encode_page() thing where the bits mean different things in different
contexts.

Anyway, this is me just explaining the thinking behind it all. The
page bit encoding is a very generic thing (well, "very generic" in
this case means "has at least one other independent user"), explaining
the very generic naming.

But at the same time, the particular _patch_ was meant to be very targeted.

So slightly schizophrenic name choices as a result.

             Linus

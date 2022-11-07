Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747CE61F924
	for <lists+linux-arch@lfdr.de>; Mon,  7 Nov 2022 17:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiKGQUQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 11:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKGQUH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 11:20:07 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7015FB5
        for <linux-arch@vger.kernel.org>; Mon,  7 Nov 2022 08:19:53 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id x21so7475870qkj.0
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 08:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kS5Pd4xumBsprbId/IA6yh5RFHUTXxa1KEDWNlrvRnQ=;
        b=TSx33kRVgTxwulhwu2I6HxDcJEacmgp8MpGqnsCbyyj3XKkEiEz7XfhbF6iMISUiSf
         lWFxDCgHXjWD2RntcRxTwHA6kde5XD3KVptLM4Y1ds4p7N5lQHTV+2HCsAWLYVpjiqsn
         ynk+bNf25hjGJ9F9siieMFz9fyb/GECkwDR7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kS5Pd4xumBsprbId/IA6yh5RFHUTXxa1KEDWNlrvRnQ=;
        b=T8DIYIceOKC4kNEhX9o52zUtdxYHz1WUv8UCrlPTKDyjUnZwHmcHH32CPuKQvrAiiQ
         4o+epdDFBHXIKp3nPiYWd2dBaE+zMG65DWKN80WfHmesLNh+DaSbNG5luqVzL5FYTl0J
         Taz+12ZlwZoV4HwFRseuzzGLO873X9pDNLljvIsFltse/1OZTD1j7jRYpCPKur0bJ5MQ
         ifv4qyeI9ZYAoLsCkjNap6xNUsPrij45mdWML29YcAECnhzFQ6O6GXLS7mm6Vk1a06Cb
         NhWFdBWwGFlEGyjPkfinBxLqrnkplFb8AhDgiX67oCeWNBohVEnxFdPatALy1RDotYX/
         L5kw==
X-Gm-Message-State: ACrzQf055n/kSBk2gbOjZyMgNbiFrYtKNHMRjX/BfL49vrTcSZkrmRio
        bDx3tbMZQOL/m5dWWA9/sxcGCne/g+ahKQ==
X-Google-Smtp-Source: AMsMyM7UazYMKagRx9ss8OtJWIq99ppV/ZBrQndr8aqxQv4ishiYsAEsoPIGbIeHEibGk54slOY4DQ==
X-Received: by 2002:a05:620a:350:b0:6fa:3012:bcea with SMTP id t16-20020a05620a035000b006fa3012bceamr29694889qkm.419.1667837992139;
        Mon, 07 Nov 2022 08:19:52 -0800 (PST)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b0039492d503cdsm6438692qta.51.2022.11.07.08.19.51
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 08:19:51 -0800 (PST)
Received: by mail-yb1-f181.google.com with SMTP id g127so14209671ybg.8
        for <linux-arch@vger.kernel.org>; Mon, 07 Nov 2022 08:19:51 -0800 (PST)
X-Received: by 2002:a81:8485:0:b0:369:a331:c737 with SMTP id
 u127-20020a818485000000b00369a331c737mr760030ywf.401.1667837980584; Mon, 07
 Nov 2022 08:19:40 -0800 (PST)
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
 <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
 <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com> <CAHk-=wgvx5sDaOfCTMkVpZ9+-iFCeh5AOML5aJG1EiR0+e1aBQ@mail.gmail.com>
 <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
In-Reply-To: <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Nov 2022 08:19:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
Message-ID: <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
Subject: Re: mm: delay rmap removal until after TLB flush
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
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

On Sun, Nov 6, 2022 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> Yes, I've removed both serieses and shall push the tree out within half
> an hour from now.

Oh, can you please just put Hugh's series back in?

I don't love the mapcount changes, but I'm going to re-do my parts so
that there is no clash with them.

And while I'd much rather see the mapcounts done another way, that's a
completely separate issue.

                Linus

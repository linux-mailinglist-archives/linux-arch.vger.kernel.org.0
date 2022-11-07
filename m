Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB483620329
	for <lists+linux-arch@lfdr.de>; Tue,  8 Nov 2022 00:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbiKGXCs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Nov 2022 18:02:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiKGXCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Nov 2022 18:02:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 043C92A245;
        Mon,  7 Nov 2022 15:02:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6D921B816AA;
        Mon,  7 Nov 2022 23:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0E7C433D7;
        Mon,  7 Nov 2022 23:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1667862164;
        bh=jKeiZI0mgE0HDDAQ2brW55vTJxq10NgNZw8Hpkh+Xsc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qNfHcpDVW1jxTuKgSmg0pdY9mpw+c9FHq43ZzfsQy09s3ct5VoZ86A5eXCFHvrPOR
         3gRpLjGJ36ul+YPp/eYo3Sr9yKN8k+Hx1p8MP247fkR59MAruM52Iut/oDrJZTrgm6
         jzYMhOlWXIuOt4l6kuUi/rMpllxFOYsVfmBZryfU=
Date:   Mon, 7 Nov 2022 15:02:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
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
Subject: Re: mm: delay rmap removal until after TLB flush
Message-Id: <20221107150242.722ba8238cab04bf3c6dbc39@linux-foundation.org>
In-Reply-To: <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
References: <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
        <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
        <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
        <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
        <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
        <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
        <Y1+XCALog8bW7Hgl@hirez.programming.kicks-ass.net>
        <CAHk-=wjnvPA7mi-E3jVEfCWXCNJNZEUjm6XODbbzGOh9c8mhgw@mail.gmail.com>
        <CAHk-=wjjXQP7PTEXO4R76WPy1zfQad_DLKw1GKU_4yWW1N4n7w@mail.gmail.com>
        <Y2SyJuohLFLqIhlZ@li-4a3a4a4c-28e5-11b2-a85c-a8d192c6f089.ibm.com>
        <CAHk-=wjzp65=-QE1dg8KfqG-tVHiT+yAfHXGx9sro=8yOceELg@mail.gmail.com>
        <8a1e97c9-bd5-7473-6da8-2aa75198fbe8@google.com>
        <CAHk-=wgvx5sDaOfCTMkVpZ9+-iFCeh5AOML5aJG1EiR0+e1aBQ@mail.gmail.com>
        <20221106151416.bc2f942f237de31b6c577e70@linux-foundation.org>
        <CAHk-=wgA=PyH=OuKzhUhxKyN2jOQNy5VcQwsqtnjBKG3jDhpCg@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 7 Nov 2022 08:19:24 -0800 Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Sun, Nov 6, 2022 at 3:14 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > Yes, I've removed both serieses and shall push the tree out within half
> > an hour from now.
> 
> Oh, can you please just put Hugh's series back in?
> 

Done, all pushed out to
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm mm-unstable.


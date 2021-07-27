Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5AA3D72EB
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbhG0KRZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 06:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbhG0KRY (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 06:17:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E419C061764
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5k45kly44+pqVmHGMKU4wiLe+0Gu+CpxUPHHT5h5o3M=; b=SZ6HokUSzCTdUzd1KHtgS2a7ws
        CecTZP0FjqFkvhvkO1PHmpZR2kwl4i2ejy89amU3nF72ZeWCpKhCC+QHx5vsmYrnJVkV9s2VZMZ1Z
        Z4ZYVqfTp1uTUOat/FrY3aV2sOgbbm6dv2X3/HI7EI9+3gNYD1crhvGrBnA1EE9UTtbfla3KwEoKF
        rmt4VW8PS+5p60M4phTfME7/2XD+MliMdsu1sWkOv0N/ePDuQbiB4XJT8wXF8a68mBx0a3J6s01en
        RfqNOJFGIBnoFaH1I1mGta1SbP5InkwXYjKdYbWmh4qOq8fC8TYqpqkGNc95e6IFkSIbjhXTJAY4a
        XTwiOoow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8K4u-00Eu4m-TU; Tue, 27 Jul 2021 10:13:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4F5F2300279;
        Tue, 27 Jul 2021 12:12:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 23918213986E8; Tue, 27 Jul 2021 12:12:47 +0200 (CEST)
Date:   Tue, 27 Jul 2021 12:12:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Guo Ren <guoren@kernel.org>, Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YP/cHzVmebtbMDBF@hirez.programming.kicks-ass.net>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YP7q5GBweaeWgvcs@boqun-archlinux>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 01:03:32AM +0800, Boqun Feng wrote:

> I'm missing you point here, a) ll/sc can provide forward progress and b)
> ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> PPC).

Correct on both counts, but b) is tricky, even if a), then it doesn't
hold that the primitive resulting from b) also provides fwd progress.

I feel this point is often overlooked. I should go add something to
atomic_t.txt about that I suppose.

> > How to make CPU guarantee  "load + cmpxchg" forward-progress? Fusion
> > these instructions and lock the snoop channel?
> > Maybe hardware guys would think that it's easier to implement cas +
> > dcas + amo(short & byte).
> > 
> 
> Please note that if _Q_PENDING_BITS == 1, then the xchg_tail() is
> implemented as a "load + cmpxchg", so if "load + cmpxchg" implementation
> of xchg16() doesn't provide forward-progress in an architecture, neither
> does xchg_tail().

Right, so generally we rely on cmpxchg() to provide fairness. Some
architectures (notably Sparc64) go to great lengths to ensure this.

I have memories of adding backoff to an LL/SC based arch at some point,
but I cannot find it in a hurry, so it could be one of the since deleted
archs.

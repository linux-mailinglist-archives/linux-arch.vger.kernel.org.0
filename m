Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68E473D73C7
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 12:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhG0KyS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 06:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236169AbhG0KyQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 06:54:16 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DA2FC061757
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 03:54:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DNqwh6LVo5k9Iu7auIkYS6Hmt3s+6oyHsPrYf7Emxgk=; b=UrbGCWVtOiKwkTgDdV13SkhzjX
        +bDOGuZ3kfmvvMPgWA17xQrrSJIZ4xC7BaDn9yNfCpipl68dj3Wm3X6Qs0LZizYGtlnxu5NuRK6G4
        7DbTCC3l9mRKQASq/qzLP34Y1uBtq+bg0ZLoqffMV7RBisaX/tvCWx804YpLoLEECT7AgIG4POH/z
        qMyzydfPMJZrvg2r81h2h6VRQ3zMIn/ktMrTPPumhta1HZ5DIwDSfhb8tLkI36+H3AcmPEwBxuAih
        c6LGj/dsGb5Db2K3ROoypSRh1816QucVFkOvHpLuBQAOZHzcA2zwLTlyKgKWzFHnWyRsEB1oM1JzL
        qUF6KEjw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8KfJ-00EvrX-DU; Tue, 27 Jul 2021 10:50:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4AD8D300215;
        Tue, 27 Jul 2021 12:50:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3A5A2200E37D0; Tue, 27 Jul 2021 12:50:23 +0200 (CEST)
Date:   Tue, 27 Jul 2021 12:50:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
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
Message-ID: <YP/k7xB8DwbBI9Lx@hirez.programming.kicks-ass.net>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 09:07:44AM +0800, Guo Ren wrote:
> On Tue, Jul 27, 2021 at 1:03 AM Boqun Feng <boqun.feng@gmail.com> wrote:

> > I'm missing you point here, a) ll/sc can provide forward progress and b)
> > ll/sc instructions are used to implement xchg/cmpxchg (see ARM64 and
> > PPC).
> I don't think arm64 could provide fwd guarantee with ll/sc, otherwise,
> they wouldn't add ARM64_HAS_LSE_ATOMICS for large systems.

You can do LL/SC with fwd progress, it's just that AMOs can be done
faster.

> That's the problem of "_Q_PENDING_BITS == 1", no hardware could
> provide "load + ALU + cas" fwd guarantee!
> 
> A simple example, atomic a++:
> c = READ_ONCE(g_value);
> new = c + 1;
> while ((old = cmpxchg(&g_value, c, new)) != c) {
>     c = old;
>     new = c + 1;
> }
> 
> Q: When it runs on CPU0(500Mhz) & CPU1(2Ghz) in one SMP, how do we
> prevent CPU1 from starving CPU0?

By not handing the cacheline to CPU1 for a while, similar to LL/SC.

The traditional way of making this work is for LL to hold onto the
exclusive state for a while and the same for a failed CAS. Simply refuse
to yield the line for a while.

OoO CPUs can get all fancy and detect the loop, but simply holding onto
the line for some N instructions mostly works.

The obvious problem is that the LL/SC fwd progress doesn't extend to
cmpxchg() implemented using LL/SC. Typically the body of the cmpxchg()
loop does things that break the exclusive hold.

For things like lock implementations, the best way is to make sure the
primitives are in native form, in this case using xchg16 implemented
with LL/SC (note that implementing xchg16() using cmpxchg() in terms of
LL/SC is terrible and throws everything out the window again).

And if the native form doesn't provide fwd progress, your best option is
to switch to a better architecture :-)


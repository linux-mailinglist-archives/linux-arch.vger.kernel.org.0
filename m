Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F253D8C67
	for <lists+linux-arch@lfdr.de>; Wed, 28 Jul 2021 13:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbhG1LDX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 28 Jul 2021 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhG1LDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 28 Jul 2021 07:03:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85110C061757
        for <linux-arch@vger.kernel.org>; Wed, 28 Jul 2021 04:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Q/EqnMCUCzpUwjgY9jY95DS8VyatsgAAEmsbgHeZMT4=; b=t5/DJn3BtBwg5czwA1CE0yWmhZ
        w3PS+gPUSLaTsfIXqAAY1ES2jF0DkLk+YseIhY2zPexDUVmtu+UTS9Ho88BesmOcSXpa1ptzZcy6L
        Uv42af7oVmx5kNAUcbyjUtnW/I/TdJubBaq0u3nNHv+t44rtYjKXtsdTeH0Bj2MI7ujFvb57MNbzW
        RjEjCX2HW7ybK9YIaViK55WpQcyhsGMyQkB+kuEP6qWW8+E4Wg0O6EK1tMjNTL1zn01SmWeYBxu3y
        R/l962MzP8OmYWrpLFCCtJIzvXKyDNsBNk2Rm5s9brQrftjyxZEfHYnjnmNpZGK85PB3XE9EsFPBA
        8ZdXNSkQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8hJY-00FyGh-Le; Wed, 28 Jul 2021 11:01:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51CFB30005A;
        Wed, 28 Jul 2021 13:01:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25D6C21071BE7; Wed, 28 Jul 2021 13:01:27 +0200 (CEST)
Date:   Wed, 28 Jul 2021 13:01:27 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Guo Ren <guoren@kernel.org>,
        Waiman Long <llong@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Rui Wang <wangrui@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YQE5B6ecrnIoXhpI@hirez.programming.kicks-ass.net>
References: <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <77e83baf-030c-1332-609c-6d3f01bd422a@redhat.com>
 <CAJF2gTQcmN0TdX2dMT5mqKBp2HJ15_7KzDnaM5VyHaCArrnfGA@mail.gmail.com>
 <YP9vp8/acj9TpwyZ@boqun-archlinux>
 <YP/oYc1A39bMS87H@hirez.programming.kicks-ass.net>
 <CAAhV-H7Jnoa3AOTjG_=+WvxkcjqDxYVU4jAudjnu8WMtAVyPCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H7Jnoa3AOTjG_=+WvxkcjqDxYVU4jAudjnu8WMtAVyPCw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jul 28, 2021 at 06:40:54PM +0800, Huacai Chen wrote:
> Hi, Peter,
> 
> On Tue, Jul 27, 2021 at 7:06 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Tue, Jul 27, 2021 at 10:29:59AM +0800, Boqun Feng wrote:
> >
> > > > "How to implement xchg_tail" shouldn't force with _Q_PENDING_BITS, but
> > > > the arch could choose.
> > >
> > > I actually agree with this part, but this patchset failed to provide
> > > enough evidences on why we should choose xchg_tail() implementation
> > > based on whether hardware has xchg16, more precisely, for an archtecture
> > > which doesn't have a hardware xchg16, why cmpxchg emulated xchg16() is
> > > worse than a "load+cmpxchg) implemeneted xchg_tail()? If it's a
> > > performance reason, please show some numbers.
> >
> > Right. Their problem is their broken xchg16() implementation.
> 
> Please correct me if I'm wrong. Now my understanding is like this:
> 1, _Q_PENDING_BITS=1 qspinlock can be used by all archs, though it may
> be not optimized.

Only if your arch has fwd progress guarantees for cmpxchg(). LL/SC based
cmpxchg() is tricky, and typically needs software based backoff on
failure.

The qspinlock code is written in generic code, but it very much relies
on an architecture to audit and vet the resulting code is sane for them.
Clearly MIPS didn't do a good job of that.

> 2, _Q_PENDING_BITS=8 qspinlock can be used if hardware supports
> sub-word xchg/cmpxchg, or the software emulation is correctly
> implemented. But the current MIPS emulation is not correct.

Everything always relies on things being correctly implemented. 1)
relies on cmpxchg() being correctly implemented. 2) relies on xchg16()
being correctly implemented.

Of these 2 is actually easier to implement correctly on LL/SC.

> If so, I want to rename ARCH_HAS_HW_XCHG_SMALL to
> ARCH_HAS_FAST_XCHG_SMALL, and let these archs select it:
> 1, X86, ARM, ARM64, IA64, M68K, because they have hardware support.
> 2, Other archs who select qspinlock currently (including MIPS),
> because their current behavior is use _Q_PENDING_BITS=8 qspinlock and
> we don't want to change anything in this patch. If their emulation is
> broken or not as "fast" as expected, we can make new patches to
> unselect the ARCH_HAS_FAST_XCHG_SMALL option.

I utterly fail to see the point of any of this. If you use qspinlock,
you had better have audited the whole thing for your architecture. And
FAST_XCHG_SMALL is completely irrelevant for anything here.


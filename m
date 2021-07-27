Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 915E83D73FC
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jul 2021 13:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbhG0LDX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jul 2021 07:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbhG0LDW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jul 2021 07:03:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0295C061757
        for <linux-arch@vger.kernel.org>; Tue, 27 Jul 2021 04:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ywSfLSaGHSXHxy/6LhSqgObIpW4zWQGHe3MYbzoVoDk=; b=Z+bKJhi9chtdwJPJD0E6c6ZdOf
        i5ZzvL+wrpsJMGo8jT5qk5GQfBVFv/y4QxtVwWO6PA+DHreLaf0vUHqRLmFiqWrmOEzS+Xe9e9tSi
        TpNTZTR9AkHqnQh/G+UfziYZ0cBjKcCSNZYcoxcC+7gTi63Jw3VJ4Inb7ytfV30lbChFai7UuMLAF
        Bx+UgeJ1C7A/ubARXbe+ljppT73z35z7R23m+JT4JeE89A8U+LCUgnn/IoT0DK9uRf022Ke8xEq3y
        ZUixJFPD4MDb2o4BZH4asswDtPR+2/PLvl4fz+nZUqO1ywYWCN2AKnKx6LcBLIz1SZP3hSoD0jQct
        FLROPc6A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m8KrZ-003QEP-Ud; Tue, 27 Jul 2021 11:03:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0478D300233;
        Tue, 27 Jul 2021 13:03:04 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E317D2018A4F0; Tue, 27 Jul 2021 13:03:03 +0200 (CEST)
Date:   Tue, 27 Jul 2021 13:03:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wang Rui <wangrui@loongson.cn>
Cc:     Guo Ren <guoren@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Huacai Chen <chenhuacai@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Waiman Long <longman@redhat.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: Re: Re: [PATCH RFC 1/2] arch: Introduce ARCH_HAS_HW_XCHG_SMALL
Message-ID: <YP/n59uBjt8O4PlX@hirez.programming.kicks-ass.net>
References: <20210724123617.3525377-1-chenhuacai@loongson.cn>
 <CAMuHMdU8o2r0Tybz_z3hKLoMyNqL5A_RZ9DnCYR0pHeRMpgvWA@mail.gmail.com>
 <CAAhV-H4aNr2BuG1imx6RcfEQtarjbrUU+-_PbGRg4jX5ygr_iA@mail.gmail.com>
 <YP6Q3s5Kpg2A1NRZ@boqun-archlinux>
 <CAJF2gTQ98v8H3SYt8K0Mnq73xXtZ-2Ja7jOaP2Uo-fX+ZqYZBw@mail.gmail.com>
 <YP7q5GBweaeWgvcs@boqun-archlinux>
 <CAJF2gTSZdi_U6we4K7Y0M9XsL++Dppdc4jh-UZFxHR+dqBq6fQ@mail.gmail.com>
 <3897b19d.ff7d.17ae5a9c6e9.Coremail.wangrui@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3897b19d.ff7d.17ae5a9c6e9.Coremail.wangrui@loongson.cn>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jul 27, 2021 at 09:52:26AM +0800, Wang Rui wrote:
> I think the forward progress are guaranteed while all operations are
> atomic(ll/sc or amo). If ll/sc runs on a fast cpu, there will be
> random delays, is that okay? Else, for such hardware, we can't even
> implement generic spinlock with ll/sc.
> 
> And I also think that the hardware supports normal store for
> unlocking. (e.g. arch_spin_unlock)
> 
> In qspinlock, when _Q_PENDING_BITS == 1, it's available for all
> hardware, because the clear_pending/clear_pending_set_locked are all
> atomic operations. Isn't it?
> 
> Q: Why live lock happens while _Q_PENDING_BITS == 8?
> A: I found a case is:
> 
> * CPU A updates sub-word of qpsinlock at high frequency with normal store.
> * CPU B do xchg_tail with load + cmpxchg, and the value of load is always not equal to the value of ll(cmpxchg).
> 
> qspinlock:
>   0: locked
>   1: pending
>   2: tail
> 
> CPU A                    CPU B
> 1:                       1: &lt;--------------------+
>   sh $newval, &amp;locked      lw  $v1, &amp;qspinlock   |
>   add $newval, 1           and $t1, $v1, ~mask   |
>   b 1b                     or  $t1, $t1, newval  | (live lock path)
>                            ll  $v2, &amp;qspinlock   |
>                            bne $v1, $v2, 1b -----+
>                            sc  $t1, &amp;qspinlock
>                            beq $t1, 0, 1b
> 
> If xchg_tail like this, at least there is no live lock on Loongson
> 
> xchg_tail:
> 
> 1:
>   ll  $v1, &amp;qspinlock
>   and $t1, $v1, ~mask
>   or  $t1, $t1, newval
>   sc  $t1, &amp;qspinlock
>   beq $t1, 0, 1b
> 
> For hardware that ll/sc is based on cache coherency, I think sc is
> easy to succeed. The ll makes cache-line is exclusive by CPU B, and
> the store of CPU A needs to acquire exclusive again, the sc may be
> completed before this.

This! I've been saying this for ages. All those xchg16() implementations
are broken for using cmpxchg() on LL/SC. Not because xchg16() is
fundamentally flawed.

Perhaps we should introduce:

	atomic_nand_or() and atomic_fetch_nand_or()

and implement short xchg() using those, then we can have the whole masks
setup shared. It just means you get to implement those primitives for
*all* archs :-)

Also, the _Q_PENDING_BITS==1 case can use that primitive.

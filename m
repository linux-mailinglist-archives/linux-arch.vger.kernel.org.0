Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D255F34CEE3
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 13:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhC2L1G (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 07:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232845AbhC2L0w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 07:26:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98EAC061574;
        Mon, 29 Mar 2021 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=a6YbhyXk219havI+95QWm2VpeZkgxPnC4TWMCB0ywQ8=; b=mQdBICEUN58k/ljPhRyt6zoRMA
        3T4WAwN/7lXYa5OdeND6gLSdaBwm/7TwSRV5qEjFJDUNS/U/4BoXP/3w6GlIBllEeKDdtbd+qammj
        4SLPg23xBZph6wQ5PrPmzAPdjepdLLnOYVcE7EEbUqLBUUu0cupzobheV5LcwFmi99j8AMSU4p3s0
        earLgpf6YD6ZhU/R8V6XkEbnHQSRqvcfM4PDnkBqJff0TcU9t3QM5vVDSoSXoSHnQMwhLWiPNm09T
        MorsyyQo9KWhc+J1JUPbuEL3NLBmDsu3NxV32qpklapB3ZT3mg+CDqfDDfsOCCX5zwlM370R7gGay
        QbmjIP0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQq2e-000cHI-4x; Mon, 29 Mar 2021 11:26:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 857B83007CD;
        Mon, 29 Mar 2021 13:26:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6C168207539C5; Mon, 29 Mar 2021 13:26:43 +0200 (CEST)
Date:   Mon, 29 Mar 2021 13:26:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 07:19:29PM +0800, Guo Ren wrote:
> On Mon, Mar 29, 2021 at 3:50 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Sat, Mar 27, 2021 at 06:06:38PM +0000, guoren@kernel.org wrote:
> > > From: Guo Ren <guoren@linux.alibaba.com>
> > >
> > > Some architectures don't have sub-word swap atomic instruction,
> > > they only have the full word's one.
> > >
> > > The sub-word swap only improve the performance when:
> > > NR_CPUS < 16K
> > >  *  0- 7: locked byte
> > >  *     8: pending
> > >  *  9-15: not used
> > >  * 16-17: tail index
> > >  * 18-31: tail cpu (+1)
> > >
> > > The 9-15 bits are wasted to use xchg16 in xchg_tail.
> > >
> > > Please let architecture select xchg16/xchg32 to implement
> > > xchg_tail.
> >
> > So I really don't like this, this pushes complexity into the generic
> > code for something that's really not needed.
> >
> > Lots of RISC already implement sub-word atomics using word ll/sc.
> > Obviously they're not sharing code like they should be :/ See for
> > example arch/mips/kernel/cmpxchg.c.
> I see, we've done two versions of this:
>  - Using cmpxchg codes from MIPS by Michael
>  - Re-write with assembly codes by Guo
> 
> But using the full-word atomic xchg instructions implement xchg16 has
> the semantic risk for atomic operations.

What? -ENOPARSE

> > Also, I really do think doing ticket locks first is a far more sensible
> > step.
> NACK by Anup

Who's he when he's not sending NAKs ?

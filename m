Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34E634D060
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 14:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhC2Mu1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 08:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbhC2MuK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 08:50:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63782C061574;
        Mon, 29 Mar 2021 05:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1918iT4uzotqNOl2NIVcMWIyYjsHFO6ajOdXvBHTmz0=; b=OsUkcjaEC5QtmphwWlRuqGUNXm
        sguIJD8uR8Q6kUa/CzuVxzzaza4CR5bOBGKP4wnkUapwhIyaIa816SR+QuolvtGEeRoMiWR2U9eOr
        Y1eGuQ39WXYD2PlMMJRwOtlSCLtcRu4QL+9EJgRmP4v9eAwl7tq2lUyzErBosRYBRiXGA6p4r3piE
        l3JMoIDOkzIUC+gtjIaBZ6l+MT9NDe1uo3vldrRNQoHOB8kZQIUDYfehHZXB4CZYq4g4KuqP6ffRZ
        BR6rRc+bXfkJyW0+ypDZRJmZNSqGj/yhXMvIYXGocXid1OhDKbYDx235eu3aXlyeJx62QZv3dzYgb
        mTqTXNMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQrKo-001aXI-L9; Mon, 29 Mar 2021 12:49:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFD843011FE;
        Mon, 29 Mar 2021 14:49:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BA3C42BB1A697; Mon, 29 Mar 2021 14:49:31 +0200 (CEST)
Date:   Mon, 29 Mar 2021 14:49:31 +0200
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
Message-ID: <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 08:01:41PM +0800, Guo Ren wrote:
> u32 a = 0x55aa66bb;
> u16 *ptr = &a;
> 
> CPU0                       CPU1
> =========             =========
> xchg16(ptr, new)     while(1)
>                                     WRITE_ONCE(*(ptr + 1), x);
> 
> When we use lr.w/sc.w implement xchg16, it'll cause CPU0 deadlock.

Then I think your LL/SC is broken.

That also means you really don't want to build super complex locking
primitives on top, because that live-lock will percolate through.

Step 1 would be to get your architecute fixed such that it can provide
fwd progress guarantees for LL/SC. Otherwise there's absolutely no point
in building complex systems with it.

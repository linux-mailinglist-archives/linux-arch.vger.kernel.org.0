Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B40E2357255
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 18:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234106AbhDGQo7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 12:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbhDGQo6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 12:44:58 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32560C061756;
        Wed,  7 Apr 2021 09:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=mSYkryVWY5Pr3drPpv2NaUgq5R5L6jkNcEwAJTVD9CE=; b=oBpo3LmmrylkwRvCPEuDqy0siY
        w6Vblo1PfrEZIOt1E6+WTUXuQFJke1qgC5BHuVW41/nyqUA2PszrAAvgoZrPSOJTaa/k9jzkkvlxX
        Yt3hLk/VrDJpfN3knC60fZIz8ODcsUQqtf1/3mBMds2HhQsk5pmsA6domWSd49QLvLIQo92h7Zcsg
        /+vQyaO4JP158BN/RlvD3p9JXSkaii3fYllmW8zSRcyBjbkek9iH+7lUIXJ7mjzRLBlU6T1zOz5HK
        EZydhVSVQNaYd2Bd7oAxxSRGHldVKXzg+8/cXvmIhUYr26mJ85htTlJLEs3Dc9ZLizVRHQaTlhXKR
        VuFPI0VQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUBIB-005V5Q-Qu; Wed, 07 Apr 2021 16:44:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B5C40300331;
        Wed,  7 Apr 2021 18:44:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9EEA423D3AF86; Wed,  7 Apr 2021 18:44:34 +0200 (CEST)
Date:   Wed, 7 Apr 2021 18:44:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Christoph =?iso-8859-1?Q?M=FCllner?= <christophm30@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>, Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YG3hcg32xw/D03P2@hirez.programming.kicks-ass.net>
References: <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net>
 <20210407094224.GA3393992@infradead.org>
 <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com>
 <YG3U677P9QKqFGMY@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YG3U677P9QKqFGMY@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 05:51:07PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 07, 2021 at 04:29:12PM +0200, Christoph Müllner wrote:
> > Further, it is not the case that RISC-V has no guarantees at all.
> > It just does not provide a forward progress guarantee for a
> > synchronization implementation,
> > that writes in an endless loop to a memory location while trying to
> > complete an LL/SC
> > loop on the same memory location at the same time.
> 
> Userspace can DoS the kernel that way, see futex.

The longer answer is that this means you cannot share locks (or any
atomic really) across a trust boundary, which is of course exactly what
futex does.

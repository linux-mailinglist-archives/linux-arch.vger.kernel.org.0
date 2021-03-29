Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EA934CF1C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 13:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbhC2Lby (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 07:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhC2Lba (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 07:31:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE170C061574;
        Mon, 29 Mar 2021 04:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xAASgCT1znE4iZyX4yKtFW+FR4NtFv4F0rZP0TttRpc=; b=IUiKLtt370+VXpr4Dpb9tIRnmD
        lUlt8V0bVGbfLA+R8YSPIs2KN/WpHeEsLTx1xJLbLiXLynAZmIxYNh4kuFIPd1cjaXGTgOSWQoOIV
        QETpqcvhbwpVKGfbKrnWvzkGFspWw6FRMud3euBEeDrqOAmp45mWd2u7Kvf3O9M4aI5VFhAcu8//F
        AOGsqL6Ut9BtLNCe6g8wHoyGxVKxBkiRTrveBGZbdnHRjwFwVYBvF/DfhKrlZ9HZXRFFvwsnKDWWN
        e5CnjI2RJ1h+QIvFIOvGX8kRLrM3d7ZO9E4RhkJ9yNOU24aaT28io+SH1vNMaNB0s+x2RrCPd/ZBl
        5izOhRpA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQq5j-001TUs-4F; Mon, 29 Mar 2021 11:30:08 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 982223069B1;
        Mon, 29 Mar 2021 13:29:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 85F90207539C8; Mon, 29 Mar 2021 13:29:54 +0200 (CEST)
Date:   Mon, 29 Mar 2021 13:29:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Anup Patel <anup@brainfault.org>,
        Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGG6Ms5Rl0AOJL2i@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAK8P3a2bNH-1VjsZmZJkvGzzZY=ckaaOK9ZGL-oD0DH4jW-+kQ@mail.gmail.com>
 <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGG3JIBVO0w6W3fg@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 01:16:53PM +0200, Peter Zijlstra wrote:
> Anyway, an additional 'funny' is that I suspect you cannot prove fwd
> progress of the entire primitive with any of this on. But who cares
> about details anyway.. :/

What's the architectural guarantee on LL/SC progress for RISC-V ? And
what if you double loop it like cmpxchg() ?

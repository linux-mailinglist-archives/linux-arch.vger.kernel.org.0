Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C380F356842
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346303AbhDGJne (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 05:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbhDGJnc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 05:43:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B782C061756;
        Wed,  7 Apr 2021 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uHRRfQiUBlAZ+WTehIjctPz3UPqgqzr8MZeVhYIZJnY=; b=TiUqf7vIpHbIUyAQ2LLRGADfFO
        sXUzLx7KL6B+iS3V+LlPGebBQ+n2zSzcmzF4HoVj6LSDpw7kj7CZRMClGNuMmNk8EKkoJ5/Whf5Yg
        mpdjOxQxHEaKKIfcVprBXVDi1sxySzND4ACUgaRggQQJ1sBmr5MWj0lUTICjF5eoVV6lGhMEMuR6X
        YzQKXCvyVBM+LiR7KwHDVGI6jrRelZ6TEDdI857fL140/jbgSJ0NoHMjMriLTs8TUbhu7v5zi6ah/
        KswtpdjjZMAwKlCMh55ch/rjKrXTOEb7dO3jl4tjEYq/+X5TGvWzI9a7UDmXTxGlx4lFejMoysRfx
        BGoFPCig==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lU4hc-00EFuS-3a; Wed, 07 Apr 2021 09:42:42 +0000
Date:   Wed, 7 Apr 2021 10:42:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Guo Ren <guoren@kernel.org>,
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
Message-ID: <20210407094224.GA3393992@infradead.org>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 06, 2021 at 09:15:50AM +0200, Peter Zijlstra wrote:
> Anyway, given you have such a crap architecture (and here I thought
> RISC-V was supposed to be a modern design *sigh*), you had better go
> look at the sparc64 atomic implementation which has a software backoff
> for failed CAS in order to make fwd progress.

It wasn't supposed to be modern.  It was supposed to use boring old
ideas.  Where it actually did that it is a great ISA, in parts where
academics actually tried to come up with cool or state of the art
ideas (interrupt handling, tlb shootdowns, the totally fucked up
memory model) it turned into a trainwreck.

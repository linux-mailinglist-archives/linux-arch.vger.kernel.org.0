Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC14356EDE
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 16:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhDGOgy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 10:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbhDGOgv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 10:36:51 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6A9C06175F;
        Wed,  7 Apr 2021 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=umJ6Er88RJ+kjsFdQDsASA99MroOE5xNDgI/QiCH4QM=; b=fhTqx06EzmDXnqGUU8Hs6T2OIO
        GJheMtfFNne1USTF67q0QdoIrXWnu7eBYLi2ZHmbcI7sUCTZXQKqe0UZW90UqjzGJA8YSkDp80XuM
        mZ9QxwKvvOiZeBewK5EjK/1DSyld9HuVW6qFKyL30Og1aOCFrgMxdz5AbLkzDwzLSQsUKoyaMmtJr
        ESsC8Z7fUNoef76ssY+daUwApH2StlHtsqwlZcA+xos4mpyDJ7Cg8FqKR4qMFg3Wc1g1hZYbVtvhU
        sT5qdbMuxxq+vFQcHComPMpEQMaJtiSsIuc1AZUOvOiHFwfVj+fcBq8djBeDRVzQDTcfz5jQtScev
        lIpiXB+A==;
Received: from hch by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lU9GF-00EbQv-KT; Wed, 07 Apr 2021 14:34:58 +0000
Date:   Wed, 7 Apr 2021 15:34:27 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Christoph M??llner <christophm30@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Guo Ren <guoren@kernel.org>,
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
Message-ID: <20210407143427.GA3479728@infradead.org>
References: <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGwKpmPkn5xIxIyx@hirez.programming.kicks-ass.net>
 <20210407094224.GA3393992@infradead.org>
 <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 04:29:12PM +0200, Christoph M??llner wrote:
> Gentlemen, please rethink your wording.
> RISC-V is neither "crap" nor a "trainwreck", regardless if you like it or not.

No, by all objective standards the RISC-V memory model and privileged
architecture is a trainwreck.  Anyone who disagrees is way out there in
the sky.

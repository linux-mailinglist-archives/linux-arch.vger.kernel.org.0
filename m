Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C834D08E
	for <lists+linux-arch@lfdr.de>; Mon, 29 Mar 2021 14:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhC2MzS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Mar 2021 08:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231687AbhC2MzG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Mar 2021 08:55:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FD7DC061574;
        Mon, 29 Mar 2021 05:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ryQUmQX9VCrgI40LMrpbOpblpt+Cjb8URzPqoIp8UFw=; b=aKCY2I+A4CoLQS4X2EJS0qhT9V
        9ldUP14p2myn0I2H7vFFLqGO2ViFxVgtMp4r7AISXPeratKP1oX1td2NT3SjHs3UHQEDIYBu/dI40
        TeEn+vntWxrKhtc6Uj4OVxkrwgL4cXU9DA/DjM2CHa03mwkVuXqeNx5fGnhKvIxXVv4zEFVpmNBkB
        fRgtFq4Ne+2TGvb2X+UXQVVUm7y5jArJzdG591z5/1eWOtycdRF+C/x8xP/UYoEpIg0DLcrhR2znb
        0YCbxNQBx7fmjOZMi8dAlDthdfL4GOwnOSYkL82gDAajM/DMqAriiVoM5XQby9P+0S1YQuKvq2mta
        vp6FxWOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lQrPU-001aoq-Jy; Mon, 29 Mar 2021 12:54:32 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E0707305CC3;
        Mon, 29 Mar 2021 14:54:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBCD02BB1A680; Mon, 29 Mar 2021 14:54:23 +0200 (CEST)
Date:   Mon, 29 Mar 2021 14:54:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Guo Ren <guoren@kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Anup Patel <anup@brainfault.org>
Subject: Re: [PATCH v4 3/4] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YGHN/4B8f9kTbcso@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <DM6PR04MB6201B2774866802C268F7B628D7E9@DM6PR04MB6201.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR04MB6201B2774866802C268F7B628D7E9@DM6PR04MB6201.namprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 29, 2021 at 12:13:10PM +0000, Anup Patel wrote:

> We had discussions in the RISC-V platforms group about this. Over there,
> We had evaluated all spin lock approaches (ticket, qspinlock, etc) tried
> in Linux till now. It was concluded in those discussions that eventually we
> have to move to qspinlock (even if we moved to ticket spinlock temporarily)
> because qspinlock avoids cache line bouncing. Also, moving to qspinlock
> will be aligned with other major architectures supported in Linux (such as
> x86, ARM64)
> 
> Some of the organizations working on high-end RISC-V systems (> 32
> CPUs) are interested in having an optimized spinlock implementation
> (just like other major architectures x86 and ARM64).
> 
> Based on above, Linux RISC-V should move to qspinlock.

That's all well and good, but first you need architectural forward
progress guarantees. Otherwise there's absolutely no point in building
complex locking primitives.

And unless you already have such big systems in silicon, where you
can benchmark against simpler locks (like ticket) there really is no
point in the complexity.


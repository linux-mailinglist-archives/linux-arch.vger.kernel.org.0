Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 231983567FA
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239868AbhDGJ1L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 05:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbhDGJ1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 05:27:10 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A2FC061756;
        Wed,  7 Apr 2021 02:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7EvUIdp/wlCWQxr7ZPtydOiAZIE8AOF6LJWb66AprgA=; b=IVl3AJ3A2s15VlLEXzaBMqEzAG
        07Z3CVqNPS2m9nbl7NSDBHZp2MtboXB12ksn/0tvYUHAInL7nuv4Io5HrNi8EvPFrGsRTziHz2dLl
        gF7erGP41IiUKKUK7o4ThpK73UVuKBgfD1C2FLW5RbXQEfFTG9+hj2kXK8uRoMknFx4wm9hCFoKbY
        C3YqIhFT2fDZHn0vQWPaj/KEPWPaCc2RZ9ks9tFMHSK/Xhm+DtjWihdNVOmQ8wVgpgGqAX0shwPO+
        SitnKpJNdl6j/batDYPdWLtrADYEbjch9RDS/qNMxtB7lSNLle8YKR1r/wMPyc+zIrscKkP09LjFi
        NQYTsZXQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU4Sc-004bir-Sa; Wed, 07 Apr 2021 09:26:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 472D130005A;
        Wed,  7 Apr 2021 11:26:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3371224403DB7; Wed,  7 Apr 2021 11:26:54 +0200 (CEST)
Date:   Wed, 7 Apr 2021 11:26:54 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <YG163mtOkTPgbqL7@hirez.programming.kicks-ass.net>
References: <1616868399-82848-1-git-send-email-guoren@kernel.org>
 <1616868399-82848-4-git-send-email-guoren@kernel.org>
 <YGGGqftfr872/4CU@hirez.programming.kicks-ass.net>
 <CAJF2gTQNV+_txMHJw0cmtS-xcnuaCja-F7XBuOL_J0yN39c+uQ@mail.gmail.com>
 <YGG5c4QGq6q+lKZI@hirez.programming.kicks-ass.net>
 <CAJF2gTQUe237NY-kh+4_Yk4DTFJmA5_xgNQ5+BMpFZpUDUEYdw@mail.gmail.com>
 <YGHM2/s4FpWZiEQ6@hirez.programming.kicks-ass.net>
 <CAJF2gTS4jexKsSiXBY=5rz53LjcLUZ1K4pxjYJDVQCWx_8JTuA@mail.gmail.com>
 <YGyZPCxJYGOvqYZQ@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGyZPCxJYGOvqYZQ@boqun-archlinux>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 01:24:12AM +0800, Boqun Feng wrote:

> Actually, "old" riscv standard does provide fwd progress ;-) In
> 
> 	https://riscv.org/wp-content/uploads/2017/05/riscv-spec-v2.2.pdf
> 
> Section "7.2 Load-Reserved/Store-Conditional Instructions":
> 
> """
> One advantage of CAS is that it guarantees that some hart eventually
> makes progress, whereas an LR/SC atomic sequence could livelock
> indefinitely on some systems. To avoid this concern, we added an

This is not inherent to CAS, there's plenty of CAS implementations that
are prone to livelock (unfortunately).

> architectural guarantee of forward progress to LR/SC atomic sequences.
> The restrictions on LR/SC sequence contents allows an implementation to
> **capture a cache line on the LR and complete the LR/SC sequence by
> holding off remote cache interventions for a bounded short time**.
> """
> 
> The guarantee is removed later due to "Earlier versions of this
> specification imposed a stronger starvation-freedom guarantee. However,
> the weaker livelock-freedom guarantee is sufficient to implement the C11
> and C++11 languages, and is substantially easier to provide in some
> microarchitectural styles."

Pff, that's just stupid. I suppose the best you can say of the C11
memory model is that it's nice that the C committee realized they needed
to catch up to the every day reality of SMP systems (which people have
been writing 'C' for ever since the 70s, since SMP is older than C
itself).

There's so much wrong with the C11 memory model and atomics, using it to
define an architecture is just backwards.

C11 cannot do RCU, C11 cannot do seqlocks, C11 cannot do deterministic
locks, C11 cannot do real systems.

C11 is garbage.

Yes, architectures need to support C11, because sadly C11 exists and
people will use it. But architectures also need to be able to do real
systems and thus should not limit themselves to C11.


Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CC7356855
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 11:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350289AbhDGJsp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 05:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350284AbhDGJsp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 05:48:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D6EC061756;
        Wed,  7 Apr 2021 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+qSokmLjMhdEnOSkSopblq5MKalEi8UUYD3QbqGxqos=; b=eC2rQ34nM7cRrzDAhzzhEN3wPe
        kTzKVXiPYsQriyTitj8XaOZiOMYSs2CmPna+vSZrzx2X+AyYzDfGkh6XwDeUaP/R2Sdhw0fUQHZoE
        xcIkVZ9BgwAGrHrQdPx1JVxc28uo8a4iZ5LllVP7TnFFfJ9CG+a4lOMAZ0xT4W5AUDITT4PKOzipn
        iYX5eNIGnsNYC8ByBciAnWPp9g9vDQf8R7DSJ/g+l6EF+CP1ntsJaOLY4qb8I0kMJDUqs+viQJKqd
        up6N4jP4nowpqWEIhSTtf6tIwQksMPnvi+P/KtQNQPk3PhCqoIF2gV1qmvrv5jzGvLRrNMJHVDhzZ
        FeCH/O7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lU4ms-00EGP6-RS; Wed, 07 Apr 2021 09:47:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 44BCF300119;
        Wed,  7 Apr 2021 11:47:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 27BB724403DB8; Wed,  7 Apr 2021 11:47:49 +0200 (CEST)
Date:   Wed, 7 Apr 2021 11:47:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Stafford Horne <shorne@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, guoren@kernel.org,
        linux-arch@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
        openrisc@lists.librecores.org, Anup Patel <anup@brainfault.org>,
        sparclinux@vger.kernel.org, Waiman Long <longman@redhat.com>,
        linux-riscv@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [OpenRISC] [PATCH v6 1/9] locking/qspinlock: Add
 ARCH_USE_QUEUED_SPINLOCKS_XCHG32
Message-ID: <YG1/xRgWlLHD4j/8@hirez.programming.kicks-ass.net>
References: <1617201040-83905-1-git-send-email-guoren@kernel.org>
 <1617201040-83905-2-git-send-email-guoren@kernel.org>
 <YGyRrBjomDCPOBUd@boqun-archlinux>
 <20210406235208.GG3288043@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406235208.GG3288043@lianli.shorne-pla.net>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 08:52:08AM +0900, Stafford Horne wrote:
> Why doesn't RISC-V add the xchg16 emulation code similar to OpenRISC?  For
> OpenRISC we added xchg16 and xchg8 emulation code to enable qspinlocks.  So
> one thought is with CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32=y, can we remove our
> xchg16/xchg8 emulation code?

CONFIG_ARCH_USE_QUEUED_SPINLOCKS_XCHG32 is guaranteed crap.

All the architectures that have wanted it are RISC style LL/SC archs,
and for them a cmpxchg loop is a daft thing to do, since it reduces the
chance of it behaving sanely.

Why would we provide something that's known to be suboptimal? If an
architecture chooses to not care about determinism and or fwd progress,
then that's their choice. But not one, I feel, we should encourage.


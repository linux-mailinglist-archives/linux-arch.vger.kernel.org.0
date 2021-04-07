Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D439357149
	for <lists+linux-arch@lfdr.de>; Wed,  7 Apr 2021 18:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354019AbhDGQAy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 7 Apr 2021 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353992AbhDGQAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 7 Apr 2021 12:00:47 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3A1C061760;
        Wed,  7 Apr 2021 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=H+ZMVpfa/CabsD8d5PA65uD38iRKxpv+RvDo3hX8JW0=; b=LI3JirhTB4v5sXB94brRFz4Bju
        Wx43cTRdICjBTwxuivVFW0b3J3HCgJtddI9O74+en4344IeBjDnThR37hrfvrEZpSdcZWUAlia37w
        p8ZNcMrV7gkhxpMv9YuImiWojpUnypK4nBh9hHAQtN9ibgSFzgip1Ga3/JPpJexePQU96Fpm1r5ux
        nG+hPED8h6w72ag7NjWKZAKLCbARHK68oucBf7/2he+6JNCoJpLIfcswTYvbJhNL2Sxvqzw39vKAr
        3DE45L+ESAD1HHwGzWYzPLTvZGHimMkQxba/wWv557j2dih+BvU3gdgjywVdj+320u3rR6c7ho/vD
        pKL64eng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lUAbH-005NDW-Kw; Wed, 07 Apr 2021 16:00:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 002B73001FB;
        Wed,  7 Apr 2021 18:00:14 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E298B2BF09269; Wed,  7 Apr 2021 18:00:14 +0200 (CEST)
Date:   Wed, 7 Apr 2021 18:00:14 +0200
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
Message-ID: <YG3XDnNc+GaW1Tz4@hirez.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHB2gtROGuoNzv5f9QrhWX=3ZtZmUM=SAjYhKqP7dTiTTQwkqA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 07, 2021 at 04:29:12PM +0200, Christoph Müllner wrote:
> RISC-V defines LR/SC loops consisting of up to 16 instructions as
> constrained LR/SC loops.  Such constrained LR/SC loops provide the
> required forward guarantees, that are expected (similar to what other
> architectures, like AArch64, have).

The text quoted by others didn't seem to say such a thing, but whatever.

> What RISC-V does not have is sub-word atomics and if required, we
> would have to implement them as LL/SC sequences. And yes, using atomic
> instructions is preferred over using LL/SC,

(psudo asm, can't be bothered to figure out the actual syntax)

	# setup r_and_mask, r_or_mask

.L1
	LL r, [word]
	AND r, r, r_and_mask
	OR r, r, r_or_mask
	SC r, [word]
	JNE .L1

is what you need for LL/SC based xchg16, that's less than 16
instructions. If RISC-V guarantees fwd progress on that, good, write it
like that and lets end this thread.

The fact that this is apparently hard, is not good.

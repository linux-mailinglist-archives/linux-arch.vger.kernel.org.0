Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD22D1184AA
	for <lists+linux-arch@lfdr.de>; Tue, 10 Dec 2019 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbfLJKQK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 05:16:10 -0500
Received: from merlin.infradead.org ([205.233.59.134]:40428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJKQK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 10 Dec 2019 05:16:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e5Wq1cFS0C0HbXjy/2CErHJ0P8SNw5EcJk6ucsk+DLA=; b=XjKOtmLCV6KJsOr0IgZ1g+Czv
        py8wpJ4igkoM+98DAQ+BsAzq6ROeHYgbzIAhjYxN915g62HCEIAxmY9Llk5cZ3HEwx/LDiXYYk5C6
        XuKD71KCcuXEF2Ni9lejLTzL1EWYRFbyF63fFY9a3p14X9SCLyJ/4qMIGtE5bgu1sFKXLMJkn2keY
        pgON83/ZTvCIZrSDe7BrSIcYsGYNldb2Rl4AyP3GWDUIcBvdJLH5+r6xzReej6ZFurrXfZ+Ia9orE
        PGYNm4mIA30Uhbt3CHeP0fudDHhD/L4VSLDjrZCUW2EMd+SIBkKG45DYrBrLOxXeqSnMDmUQI5Egs
        tyYXlInxg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iecYX-0002cL-52; Tue, 10 Dec 2019 10:15:49 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C2373305FD1;
        Tue, 10 Dec 2019 11:14:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 342092010F142; Tue, 10 Dec 2019 11:15:45 +0100 (CET)
Date:   Tue, 10 Dec 2019 11:15:45 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        elver@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, kasan-dev@googlegroups.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag
 (topic/kasan-bitops)
Message-ID: <20191210101545.GL2844@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <87wob4pwnl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wob4pwnl.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 10, 2019 at 04:38:54PM +1100, Michael Ellerman wrote:

> Good question, I'll have a look.
> 
> There seems to be confusion about what the type of the bit number is,
> which is leading to sign extension in some cases and not others.

Shiny.

> It looks like the type should be unsigned long?

I'm thinking unsigned makes most sense, I mean, negative bit offsets
should 'work' but that's almost always guaranteed to be an out-of-bound
operation.

As to 'long' vs 'int', I'm not sure, 4G bits is a long bitmap. But I
suppose since the bitmap itself is 'unsigned long', we might as well use
'unsigned long' for the bitnr too.

>   Documentation/core-api/atomic_ops.rst:  void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
>   arch/mips/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
>   arch/powerpc/include/asm/bitops.h:static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
>   arch/riscv/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
>   arch/s390/include/asm/bitops.h:static inline void arch___clear_bit_unlock(unsigned long nr,
>   include/asm-generic/bitops/instrumented-lock.h:static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
>   include/asm-generic/bitops/lock.h:static inline void __clear_bit_unlock(unsigned int nr,
> 
> So I guess step one is to convert our versions to use unsigned long, so
> we're at least not tripping over that difference when comparing the
> assembly.

Yeah, I'll look at fixing the generic code, bitops/atomic.h and
bitops/non-atomic.h don't even agree on the type of bitnr.

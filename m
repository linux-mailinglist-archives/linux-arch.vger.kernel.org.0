Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3035E119FFF
	for <lists+linux-arch@lfdr.de>; Wed, 11 Dec 2019 01:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbfLKA3X (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Dec 2019 19:29:23 -0500
Received: from ozlabs.org ([203.11.71.1]:40799 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725999AbfLKA3X (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Dec 2019 19:29:23 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Xd8v5C5Hz9sP3;
        Wed, 11 Dec 2019 11:29:19 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1576024160;
        bh=kmbp6MpyHsnC/owM/o4yDj8cWLNwjC0odjA8A0F3r2Y=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Jn2SQvPiqev5TL35DBK5lCO8mnXg+BTtXzArbhl7WqrvTJu5M+ZoiCVATKvHzLOLD
         /490q3sNuoaS8RrCEOiJfUlfiOE7FyR1xupxy+LuXjQrlnNee0sKWSvxRdwvkmFzJL
         8cX9BG/37iHETX+SK6OEUNldhJo0kpLbionDwCbFGHrNEr/2bHr8GHHP8EvBJp2w5d
         Oq7Yqge4fyyFATWKyy/JiMHOdF3ZSJiokdKFsNzkoblZu7BIUOmrVNWAjFd0ArDVZD
         MSOu1H54hdcXdP2PAhbK8MNYDb646YZe392xvS8NArPz8yhZ0UaP34j/Lsl3ab+Us5
         zD/LY1lWBWRBw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net,
        elver@google.com, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr,
        linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
        x86@kernel.org, kasan-dev@googlegroups.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops)
In-Reply-To: <20191210101545.GL2844@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net> <87wob4pwnl.fsf@mpe.ellerman.id.au> <20191210101545.GL2844@hirez.programming.kicks-ass.net>
Date:   Wed, 11 Dec 2019 11:29:16 +1100
Message-ID: <87lfrjpuw3.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Tue, Dec 10, 2019 at 04:38:54PM +1100, Michael Ellerman wrote:
>
>> Good question, I'll have a look.
>> 
>> There seems to be confusion about what the type of the bit number is,
>> which is leading to sign extension in some cases and not others.
>
> Shiny.
>
>> It looks like the type should be unsigned long?
>
> I'm thinking unsigned makes most sense, I mean, negative bit offsets
> should 'work' but that's almost always guaranteed to be an out-of-bound
> operation.

Yeah I agree.

> As to 'long' vs 'int', I'm not sure, 4G bits is a long bitmap. But I
> suppose since the bitmap itself is 'unsigned long', we might as well use
> 'unsigned long' for the bitnr too.

4G is a lot of bits, but it's not *that* many.

eg. If we had a bit per 4K page on a 32T machine that would be 8G bits.

So unsigned long seems best.

>>   Documentation/core-api/atomic_ops.rst:  void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
>>   arch/mips/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
>>   arch/powerpc/include/asm/bitops.h:static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
>>   arch/riscv/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
>>   arch/s390/include/asm/bitops.h:static inline void arch___clear_bit_unlock(unsigned long nr,
>>   include/asm-generic/bitops/instrumented-lock.h:static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
>>   include/asm-generic/bitops/lock.h:static inline void __clear_bit_unlock(unsigned int nr,
>> 
>> So I guess step one is to convert our versions to use unsigned long, so
>> we're at least not tripping over that difference when comparing the
>> assembly.
>
> Yeah, I'll look at fixing the generic code, bitops/atomic.h and
> bitops/non-atomic.h don't even agree on the type of bitnr.

Thanks.

cheers

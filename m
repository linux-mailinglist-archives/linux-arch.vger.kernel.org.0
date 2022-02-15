Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE724B65C0
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 09:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235323AbiBOISN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 03:18:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbiBOISN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 03:18:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9520811AB;
        Tue, 15 Feb 2022 00:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 84AF76166E;
        Tue, 15 Feb 2022 08:18:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DC0C36AEA;
        Tue, 15 Feb 2022 08:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644913082;
        bh=04jl3xlTAr2mAK86GyJL0xbgNN5b7HtshwArFPtWTHk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=u6mikH/4JPDH4fvTM6KTC7VSYVz8NLT6djvpq2S+8S5GNUGMzBzPDN6/lariMUqjh
         bTs1P5+Q03faefG+ovJbWOfA3bI3Y/t2J+743SoQ1eSXTvkqcBHBoxl6umVQHRsKmh
         i70KzG+xvUXNMe9n34i3ZiCOKPKsww3TVORDBT2vr+fwke91aLcRL7mEm1AFfN286C
         OopbrezoTF+Z4W18y4ulnCpWpDM/JOYGeRmROpYvBfW/0qfw/4QO/5j5oRR+g7B+c+
         rrd6KwQQTIKPgg9W3G4yWRljUgoD5ePT3wU5gLKfhXVM9Ucg48DbtuR1HQczWDp3vq
         sXhDEv8GkZXMw==
Received: by mail-wr1-f54.google.com with SMTP id d27so30694331wrc.6;
        Tue, 15 Feb 2022 00:18:02 -0800 (PST)
X-Gm-Message-State: AOAM530qCEQ6l9n8zUnUjlk5USlY/e1KTcftPGe3IHPTF0XvFy3L1e0n
        SI0DfvXZLmUQvHHxR0AvIH9CLnVLR2gDV78iHs0=
X-Google-Smtp-Source: ABdhPJw4PL6nNrFqa4c6RC8ozuX9Vj+TpXvd1rMYfibECm69yxHe+9RwBgU/na3QadsOPEjyGv1buhx93wXVXPObDfI=
X-Received: by 2002:a5d:490d:: with SMTP id x13mr2213081wrq.417.1644913080942;
 Tue, 15 Feb 2022 00:18:00 -0800 (PST)
MIME-Version: 1.0
References: <20220214163452.1568807-1-arnd@kernel.org> <20220214163452.1568807-9-arnd@kernel.org>
In-Reply-To: <20220214163452.1568807-9-arnd@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 15 Feb 2022 09:17:48 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
Message-ID: <CAMj1kXHixUFjV=4m3tzfGz7AiRWc-VczymbKuZq7dyZZNuLKxQ@mail.gmail.com>
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, monstr@monstr.eu,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>, dinguyen@kernel.org,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        openrisc@lists.librecores.org,
        "open list:PARISC ARCHITECTURE" <linux-parisc@vger.kernel.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org,
        "open list:SPARC + UltraSPARC (sparc/sparc64)" 
        <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, 14 Feb 2022 at 17:37, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> arm64 has an inline asm implementation of access_ok() that is derived from
> the 32-bit arm version and optimized for the case that both the limit and
> the size are variable. With set_fs() gone, the limit is always constant,
> and the size usually is as well, so just using the default implementation
> reduces the check into a comparison against a constant that can be
> scheduled by the compiler.
>
> On a defconfig build, this saves over 28KB of .text.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/uaccess.h | 28 +++++-----------------------
>  1 file changed, 5 insertions(+), 23 deletions(-)
>
> diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> index 357f7bd9c981..e8dce0cc5eaa 100644
> --- a/arch/arm64/include/asm/uaccess.h
> +++ b/arch/arm64/include/asm/uaccess.h
> @@ -26,6 +26,8 @@
>  #include <asm/memory.h>
>  #include <asm/extable.h>
>
> +static inline int __access_ok(const void __user *ptr, unsigned long size);
> +
>  /*
>   * Test whether a block of memory is a valid user space address.
>   * Returns 1 if the range is valid, 0 otherwise.
> @@ -33,10 +35,8 @@
>   * This is equivalent to the following test:
>   * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
>   */
> -static inline unsigned long __access_ok(const void __user *addr, unsigned long size)
> +static inline int access_ok(const void __user *addr, unsigned long size)
>  {
> -       unsigned long ret, limit = TASK_SIZE_MAX - 1;
> -
>         /*
>          * Asynchronous I/O running in a kernel thread does not have the
>          * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
> @@ -46,27 +46,9 @@ static inline unsigned long __access_ok(const void __user *addr, unsigned long s
>             (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
>                 addr = untagged_addr(addr);
>
> -       __chk_user_ptr(addr);
> -       asm volatile(
> -       // A + B <= C + 1 for all A,B,C, in four easy steps:
> -       // 1: X = A + B; X' = X % 2^64
> -       "       adds    %0, %3, %2\n"
> -       // 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
> -       "       csel    %1, xzr, %1, hi\n"
> -       // 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
> -       //    to compensate for the carry flag being set in step 4. For
> -       //    X > 2^64, X' merely has to remain nonzero, which it does.
> -       "       csinv   %0, %0, xzr, cc\n"
> -       // 4: For X < 2^64, this gives us X' - C - 1 <= 0, where the -1
> -       //    comes from the carry in being clear. Otherwise, we are
> -       //    testing X' - C == 0, subject to the previous adjustments.
> -       "       sbcs    xzr, %0, %1\n"
> -       "       cset    %0, ls\n"
> -       : "=&r" (ret), "+r" (limit) : "Ir" (size), "0" (addr) : "cc");
> -
> -       return ret;
> +       return likely(__access_ok(addr, size));
>  }
> -#define __access_ok __access_ok
> +#define access_ok access_ok
>
>  #include <asm-generic/access_ok.h>
>
> --
> 2.29.2
>

With set_fs() out of the picture, wouldn't it be sufficient to check
that bit #55 is clear? (the bit that selects between TTBR0 and TTBR1)
That would also remove the need to strip the tag from the address.

Something like

    asm goto("tbnz  %0, #55, %2     \n"
             "tbnz  %1, #55, %2     \n"
             :: "r"(addr), "r"(addr + size - 1) :: notok);
    return 1;
notok:
    return 0;

with an additional sanity check on the size which the compiler could
eliminate for compile-time constant values.

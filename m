Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750164B6A43
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 12:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236915AbiBOLHe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 06:07:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbiBOLHd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 06:07:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33FFE101F2B;
        Tue, 15 Feb 2022 03:07:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D50F51424;
        Tue, 15 Feb 2022 03:07:22 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.89.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3D4923F718;
        Tue, 15 Feb 2022 03:07:16 -0800 (PST)
Date:   Tue, 15 Feb 2022 11:07:12 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        will@kernel.org, guoren@kernel.org, bcain@codeaurora.org,
        geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org,
        shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au,
        peterz@infradead.org, mingo@redhat.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 08/14] arm64: simplify access_ok()
Message-ID: <YguJYMxJsNj9L4Ee@FVFF77S0Q05N>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-9-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-9-arnd@kernel.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 05:34:46PM +0100, Arnd Bergmann wrote:
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

I had a play around with this and a number of alternative options that had
previously been discussed (e.g. using uint128_t for the check to allow the
compiler to use the carry flag), and:

* Any sequences which we significantly simpler involved an ABI change (e.g. not
  checking tags for tasks not using the relaxed tag ABI), or didn't interact
  well with the uaccess pointer masking we do for speculation hardening.

* For all constant-size cases, this was joint-best for codegen.

* For variable-size cases the difference between options (which did not change
  ABI or break pointer masking) fell in the noise and really depended on what
  you were optimizing for.

This patch itself is clear, I believe the logic is sound and does not result in
a behavioural change, so for this as-is:

Acked-by: Mark Rutland <mark.rutland@arm.com>

As on other replies, I think that if we want to make further changes to this,
we should do that as follow-ups, since there are a number of subtleties in this
area w.r.t. tag management and speculation with potential ABI implications.

Thanks,
Mark.

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
> -	unsigned long ret, limit = TASK_SIZE_MAX - 1;
> -
>  	/*
>  	 * Asynchronous I/O running in a kernel thread does not have the
>  	 * TIF_TAGGED_ADDR flag of the process owning the mm, so always untag
> @@ -46,27 +46,9 @@ static inline unsigned long __access_ok(const void __user *addr, unsigned long s
>  	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
>  		addr = untagged_addr(addr);
>  
> -	__chk_user_ptr(addr);
> -	asm volatile(
> -	// A + B <= C + 1 for all A,B,C, in four easy steps:
> -	// 1: X = A + B; X' = X % 2^64
> -	"	adds	%0, %3, %2\n"
> -	// 2: Set C = 0 if X > 2^64, to guarantee X' > C in step 4
> -	"	csel	%1, xzr, %1, hi\n"
> -	// 3: Set X' = ~0 if X >= 2^64. For X == 2^64, this decrements X'
> -	//    to compensate for the carry flag being set in step 4. For
> -	//    X > 2^64, X' merely has to remain nonzero, which it does.
> -	"	csinv	%0, %0, xzr, cc\n"
> -	// 4: For X < 2^64, this gives us X' - C - 1 <= 0, where the -1
> -	//    comes from the carry in being clear. Otherwise, we are
> -	//    testing X' - C == 0, subject to the previous adjustments.
> -	"	sbcs	xzr, %0, %1\n"
> -	"	cset	%0, ls\n"
> -	: "=&r" (ret), "+r" (limit) : "Ir" (size), "0" (addr) : "cc");
> -
> -	return ret;
> +	return likely(__access_ok(addr, size));
>  }
> -#define __access_ok __access_ok
> +#define access_ok access_ok
>  
>  #include <asm-generic/access_ok.h>
>  
> -- 
> 2.29.2
> 

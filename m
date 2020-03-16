Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B920186DA2
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 15:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731536AbgCPOny (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 10:43:54 -0400
Received: from foss.arm.com ([217.140.110.172]:49640 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731551AbgCPOnx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 10:43:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA63E1FB;
        Mon, 16 Mar 2020 07:43:52 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84B43F52E;
        Mon, 16 Mar 2020 07:43:49 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:43:47 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 18/26] arm64: Introduce asm/vdso/processor.h
Message-ID: <20200316144346.GF3005@mbp>
References: <20200313154345.56760-1-vincenzo.frascino@arm.com>
 <20200313154345.56760-19-vincenzo.frascino@arm.com>
 <20200315182950.GB32205@mbp>
 <c2c0157a-107a-debf-100f-0d97781add7c@arm.com>
 <20200316103437.GD3005@mbp>
 <77a2e91a-58f4-3ba3-9eef-42d6a8faf859@arm.com>
 <20200316112205.GE3005@mbp>
 <9a0a9285-8a45-4f65-3a83-813cabd0f0d3@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a0a9285-8a45-4f65-3a83-813cabd0f0d3@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 16, 2020 at 01:35:17PM +0000, Vincenzo Frascino wrote:
> On 3/16/20 11:22 AM, Catalin Marinas wrote:
> > As I said above, I don't see how removing 'if ((u32)ts >= (1UL << 32))'
> > makes any difference. This check was likely removed by the compiler
> > already.
> > 
> > Also, userspace doesn't have a trivial way to figure out TASK_SIZE and I
> > can't see anything that tests this in the vdsotest (though I haven't
> > spent that much time looking). If it's hard-coded, note that arm32
> > TASK_SIZE is different from TASK_SIZE_32 on arm64.
> > 
> > Can you tell what actually is failing in vdsotest if you remove the
> > TASK_SIZE_32 checks in the arm64 compat vdso?
> 
> To me does not seem optimized out. Which version of the compiler are you using?

I misread the #ifdef'ery in asm/processor.h. So with 4K pages,
TASK_SIZE_32 is (1UL<<32)-PAGE_SIZE. However, with 64K pages _and_
CONFIG_KUSER_HELPERS, TASK_SIZE_32 is 1UL<<32 and the check is removed
by the compiler.

With the 4K build, __vdso_clock_gettime starts as:

00000194 <__vdso_clock_gettime>:
 194:   f511 5f80       cmn.w   r1, #4096       ; 0x1000
 198:   d214            bcs.n   1c4 <__vdso_clock_gettime+0x30>
 19a:   b5b0            push    {r4, r5, r7, lr}
 ...
 1c4:   f06f 000d       mvn.w   r0, #13
 1c8:   4770            bx      lr

With 64K pages:

00000194 <__vdso_clock_gettime>:
 194:   b5b0            push    {r4, r5, r7, lr}
 ...
 1be:   bdb0            pop     {r4, r5, r7, pc}

I haven't tried but it's likely that the vdsotest fails with 64K pages
and compat enabled (requires EXPERT).

> Please find below the list of errors for clock_gettime (similar for the other):
> 
> passing UINTPTR_MAX to clock_gettime (VDSO): terminated by unexpected signal 7
> clock-gettime-monotonic/abi: 1 failures/inconsistencies encountered

Ah, so it uses UINTPTR_MAX in the test. Fair enough but I don't think
the arm64 check is entirely useful. On arm32, the check was meant to
return -EFAULT for addresses beyond TASK_SIZE that may enter into the
kernel or module space. On arm64 compat, the kernel space is well above
the reach of the 32-bit code.

If you want to preserve some compatibility for this specific test, what
about checking for wrapping around 0, I think it would make more sense.
Something like:

	if ((u32)ts > UINTPTR_MAX - sizeof(*ts) + 1)

-- 
Catalin
